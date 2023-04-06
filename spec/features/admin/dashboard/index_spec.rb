require "rails_helper"

RSpec.describe "Admin Dashboard", type: :feature do
  before(:each) do
    @admin = create(:user, password: "Admin123", role: 1)
    @user_1 = create(:user, password: "test123")
    @user_2 = create(:user, password: "test234")
    @user_3 = create(:user, password: "test345")
  end

  context "As an Admin" do
    context "When I visit the admin dashboard, I can see a list of registered user email addresses" do
      it "each email address is a link to that user's show page" do
        visit root_path
        log_in(@admin)

        expect(current_path).to eq(admin_dashboard_index_path)
        expect(page).to_not have_link("Log In")

        within "#user_#{@user_3.id}" do
          expect(page).to have_link(@user_3.email)
        end
        
        within "#user_#{@user_2.id}" do
          expect(page).to have_link(@user_2.email)
        end
        
        within "#user_#{@user_1.id}" do
          expect(page).to have_link(@user_1.email)
          click_link @user_1.email
          expect(current_path).to eq(admin_user_path(@user_1))
        end
      end
    end
  end

  context "As a User or visitor" do
    it "I cannot visit the admin dashboard" do
      visit admin_dashboard_index_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You must be an admin to view this page")
      
      visit root_path
      log_in(@user_1)

      visit admin_dashboard_index_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You must be an admin to view this page")
    end
  end
end