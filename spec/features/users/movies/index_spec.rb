require 'rails_helper'

describe 'Movies Index User Story 10', :vcr do
  before(:each) do
    @stan = create(:user, password: "test123")
    visit user_discover_index_path(@stan)
  end
  
  describe "movies results page" do
    it "routes properly" do
      fill_in :search, with: "bat"
      click_button "Find Movies"

      expect(current_path).to eq("/users/#{@stan.id}/movies")
    end

    it "has a button to return to the discover page" do
      fill_in :search, with: "bat"
      click_button "Find Movies"
      click_button "Discover Page"

      expect(current_path).to eq(user_discover_index_path(@stan))
    end

    it "shows the movie title (as link) and vote average" do
      fill_in :search, with: "bat"
      click_button "Find Movies"

      expect(page).to have_content("Batman: The Doom That Came to Gotham - Vote Average: ")
      expect(page).to have_content("Dragon Ball Z: Battle of Gods - Vote Average: ")
      expect(page).to have_link("Batman: The Doom That Came to Gotham")
      expect(page).to have_link("Dragon Ball Z: Battle of Gods")
      
      # click_link "Batman: The Doom That Came to Gotham"
      # expect(current_path).to eq("/users/#{@stan.id}/movies/1003579")
    end

    it "has a link to the top movies page" do
      click_button "Find Top Rated Movies"
      expect(current_path).to eq(user_movies_path(@stan))
      expect(page).to have_content("The Godfather - Vote Average: 8.7")
      expect(page).to have_content("Shawshank Redemption - Vote Average: 8.7")
      expect(page).to have_content("The Dark Knight - Vote Average: 8.5")
    end
  end
end