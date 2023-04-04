require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create!(name: "Bob Johnson", email: "bob@example.com", password: "test123")

    visit root_path

    click_link "Log In"

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq("/users/#{user.id}")
    
    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    click_link "Home"

    expect(page).to_not have_link("Log In")
    expect(page).to_not have_link("Create New User")

    click_link "Log Out"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You have been logged out")
    expect(page).to have_link("Log In")
    expect(page).to have_button("Create New User")
  end
end