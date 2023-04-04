require "rails_helper"

RSpec.describe "Landing", type: :feature do
  before(:each) do
    @user_1 = create(:user, password: "test123")
    @user_2 = create(:user, password: "test234")
    @user_3 = create(:user, password: "test345")

    visit root_path
  end

  describe "User Story 4" do
    it "shows the landing page with the name of the app and a button to create a new user" do
      expect(page).to have_content("Viewing Party")
      expect(page).to have_button("Create New User")

      click_button "Create New User"
      expect(current_path).to eq(register_path)
    end

    it "when user is logged in, it shows the existing users" do
      click_link "Log In"

      fill_in :email, with: @user_1.email
      fill_in :password, with: @user_1.password

      click_on "Log In"
      click_link "Home"

      expect(page).to have_content("Existing Users")
      expect(page).to have_content("#{@user_1.name} - #{@user_1.email}")
      expect(page).to have_content("#{@user_2.name} - #{@user_2.email}")
      expect(page).to have_content("#{@user_3.name} - #{@user_3.email}")
    end

    it "has a link to the landing page" do
      expect(page).to have_link("Home", href: root_path)
    end
  end
end
