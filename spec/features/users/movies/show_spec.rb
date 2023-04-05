require 'rails_helper'

describe 'Movie Details Page', :vcr do
  describe "As a user, when I visit a movie's detail page" do

    before(:each) do
      @stan = create(:user, password: "test123")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@stan)

      visit user_movie_path(@stan, 550) #Fight Club id is 550
    end
      
    it "I see a button to return to the discover page" do
      click_button "Discover Page"
      
      expect(current_path).to eq(user_discover_index_path(@stan))
    end

    it "I see a button to create a new viewing party" do
      click_button "Create Viewing Party for Fight Club"
      
      expect(current_path).to eq("/users/#{@stan.id}/movies/550/viewing_party/new")
    end

    it "shows the title, vote_avg, runtime, genres, summary, cast, reviews" do
      expect(page).to have_content("Fight Club")

      within "#movie_info" do
        expect(page).to have_content("Vote: 8.431")
        expect(page).to have_content("Runtime: 2h 19min")
        expect(page).to have_content("Genre(s): Drama, Thriller, Comedy")
        expect(page).to have_content('A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground "fight clubs" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.')
        expect(page).to have_content('Edward Norton - "The Narrator"')
        expect(page).to have_content('Brad Pitt - "Tyler Durden"')
        expect(page).to have_content('Helena Bonham Carter - "Marla Singer"')
      end
    end
  end
end