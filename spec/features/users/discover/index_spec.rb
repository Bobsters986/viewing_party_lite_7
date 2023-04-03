require "rails_helper"

RSpec.describe "User's Discover Index", type: :feature do
  before(:each) do
    @stan = User.create!(name: "Stan Johnson", email: "stan@example.com", password: "test123")
    visit user_discover_index_path(@stan)
  end

  describe "User Story 9" do
    describe "As a user, when I visit a users discover page (/users/:id/discover)" do
      it "I see a button to 'Find Top Rated Movies, that routes me to the movies index page" do
        VCR.use_cassette(:top_rated_movies, serialize_with: :json) do
          expect(page).to have_button "Find Top Rated Movies"

          click_button "Find Top Rated Movies"

          expect(current_path).to eq("/users/#{@stan.id}/movies")
          
        end
      end

      it "I see see a text field to enter keyword(s) to search by movie title" do
        within "#search_form" do
          expect(page).to have_field(:search)
        end
      end

      it "I see a button to search by movie title, that routes me to the movies index page" do
        VCR.use_cassette(:find_movies, serialize_with: :json) do
          within "#search_form" do
            expect(page).to have_button "Find Movies"

            fill_in :search, with: "bat"

            click_button "Find Movies"

            expect(current_path).to eq("/users/#{@stan.id}/movies")
            
          end
        end
      end
    end
  end
end
