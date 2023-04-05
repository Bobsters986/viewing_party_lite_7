require 'rails_helper'

describe 'New Viewing Party Creation User Story 12', :vcr do
  before(:each) do
    @user = create(:user, password: "test123")
    @friend_1 = create(:user, password: "test124")
    @friend_2 = create(:user, password: "test125")
    @friend_3 = create(:user, password: "test126")

    log_in(@user)
    visit new_user_movie_viewing_party_path(1003579)
  end

  it "shows the movie title" do
    expect(page).to have_content("Batman: The Doom That Came to Gotham")
  end

  it "has a form to create a new viewing party (Duration, Day, and Start Time)" do
    within "#party_form" do
      expect(page).to have_field("Duration of Party")
      expect(page).to have_field(:duration, :with => 86)
      expect(page).to have_field("Day")
      expect(page).to have_field("Start Time")
    end
  end

  xit "has each existing user in the system with checkboxes to select invitees" do
    within "#user_#{@friend_1.id}" do
      expect(page).to have_content("#{@friend_1.name} (#{@friend_1.email})")
      check :guest_id
    end

    within "#user_#{@friend_2.id}" do
      expect(page).to have_content("#{@friend_2.name} (#{@friend_2.email})")
      check :guest_id
    end

    within "#user_#{@friend_3.id}" do
      expect(page).to have_content("#{@friend_3.name} (#{@friend_3.email})")
      check :guest_id
    end
  end

  it "creates a new party" do
    fill_in "Duration of Party", with: 100
    fill_in :day, with: "12/02/23"
    fill_in :time, with: "8:00 PM"

    

    check @friend_1.name
    check @friend_2.name

    click_button "Create Party"

    # expect(Party.all.count).to eq(1)
  end

  describe "sad path" do
    xit "does not create a party if party duration < movie.runtime" do

    end
  end
end