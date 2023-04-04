require "rails_helper"

RSpec.describe "Visitor Landing", type: :feature do
  before(:each) do
    @user_1 = create(:user, password: "test123")
    @user_2 = create(:user, password: "test234")
    @user_3 = create(:user, password: "test345")

    visit root_path
  end

  describe "Visitor Authorization" do
    it "shows the landing page with the name of the app and a button to create a new user" do
      expect(page).to have_content("Viewing Party")
      expect(page).to have_button("Create New User")
    end

    it "I do not see the section of the page that lists existing users" do
      expect(page).to_not have_content("Existing Users")
      expect(page).to_not have_content("#{@user_1.name} - #{@user_1.email}")
      expect(page).to_not have_content("#{@user_2.name} - #{@user_2.email}")
      expect(page).to_not have_content("#{@user_3.name} - #{@user_3.email}")
    end
  end
end