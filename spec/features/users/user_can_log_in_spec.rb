require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create!(name: "Bob Johnson", email: "bob@example.com", password: "test123")

    visit root_path

    click_link "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq("/users/#{user.id}")

    expect(page).to have_content("Welcome, #{user.name}")
  end
end