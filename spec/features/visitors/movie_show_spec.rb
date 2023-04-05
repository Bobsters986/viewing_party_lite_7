require "rails_helper"

describe "Visitor Authorization Movie Show", :vcr do
  before(:each) do
    #visitor = user who's not logged in
    @user_1 = create(:user, password: "test123")
    visit user_movie_path(@user_1, 550) #Fight Club id is 550
  end

  it "cant create a viewing party if not logged in" do
    click_button "Create Viewing Party for Fight Club"
    
    expect(page).to have_content("You must be logged in or registered to create a viewing party")
    expect(current_path).to eq(user_movie_path(@user_1, 550))
  end
end

