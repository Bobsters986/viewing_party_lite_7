require 'rails_helper'

RSpec.describe 'Movie Details Page' do
  before(:each) do
    @stan = create(:user, password: "test123")

    # VCR.insert_cassette(:movie_by_id_info, serialize_with: :json) do
    #   VCR.insert_cassette(:cast_info, serialize_with: :json) do
    #     VCR.insert_cassette(:review_info, serialize_with: :json) do
    #       visit user_movie_path(@stan, 550) #Fight Club id is 550
    #     end
    #   end
    # end
    VCR.eject_cassette(:movie_by_id_info)
    VCR.eject_cassette(:cast_info)
    VCR.eject_cassette(:review_info)
  end

  describe "User Story 11 - Movie Show Page" do
    describe "As a user, when I visit a movie's detail page (/users/:user_id/movies/:movie_id)" do
      it "I see a button to return to the discover page" do
        VCR.insert_cassette(:movie_by_id_info, serialize_with: :json) do
          VCR.insert_cassette(:cast_info, serialize_with: :json) do
            VCR.insert_cassette(:review_info, serialize_with: :json) do
              visit user_movie_path(@stan, 550) #Fight Club id is 550
              click_button "Discover Page"
              
              expect(current_path).to eq(user_discover_index_path(@stan))
              
            end
          end
        end
      end

      it "I see a button to create a new viewing party" do
        VCR.insert_cassette(:movie_by_id_info, serialize_with: :json) do
          VCR.insert_cassette(:cast_info, serialize_with: :json) do
            VCR.insert_cassette(:review_info, serialize_with: :json) do
              visit user_movie_path(@stan, 550)
              click_button "Create Viewing Party for Fight Club"
              

              expect(current_path).to eq("/users/#{@stan.id}/movies/550/viewing_party/new")
            end
          end
        end
      end

      it "shows the movie information" do
        VCR.insert_cassette(:movie_by_id_info, serialize_with: :json) do
          VCR.insert_cassette(:cast_info, serialize_with: :json) do
            VCR.insert_cassette(:review_info, serialize_with: :json) do
              visit user_movie_path(@stan, 550)
              expect(page).to have_content("Fight Club")

              within "#movie_info" do
                expect(page).to have_content("Vote: 8.432")
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
      end

      it "shows movie reviews" do
        # 
        VCR.insert_cassette(:movie_by_id_info, serialize_with: :json) do
          VCR.insert_cassette(:cast_info, serialize_with: :json) do
            VCR.insert_cassette(:review_info, serialize_with: :json) do
              visit user_movie_path(@stan, 550)
              expect(page).to have_content("Pretty awesome movie. It shows what one crazy person can convince other crazy people to do. Everyone needs something to believe in. I recommend Jesus Christ, but they want Tyler Durden.")
            end
          end
        end
      end
    end
  end
end