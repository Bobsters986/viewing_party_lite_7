require "rails_helper"

RSpec.describe "Visitor Movie Show", type: :feature do
  before(:each) do
    #visitor = user who's not logged in
    @user_1 = create(:user, password: "test123")

    VCR.eject_cassette(:movie_by_id_info)
    VCR.eject_cassette(:cast_info)
    VCR.eject_cassette(:review_info)
  end

  describe "Visitor Authorization" do
    it "cant create a viewing party if not logged in" do
      VCR.insert_cassette(:movie_by_id_info, serialize_with: :json) do
        VCR.insert_cassette(:cast_info, serialize_with: :json) do
          VCR.insert_cassette(:review_info, serialize_with: :json) do
            visit user_movie_path(@user_1, 550) #Fight Club id is 550
            
          end
        end
      end
      save_and_open_page
      click_button "Create Viewing Party for Fight Club"
      expect(page).to have_content("You must be logged in or registered to view this page")
      expect(current_path).to eq(root_path)
    end
  end
end

