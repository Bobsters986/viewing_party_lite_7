require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create!(name: "Bob Johnson", email: "bob@example.com", password: "test123")

    visit root_path

    click_link "Log In"

    expect(current_path).to eq("/sessions/new")

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq("/dashboard")

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it "cannot log in with invalid credentials" do
    user = User.create!(name: "Bob Johnson", email: "bob@example.com", password: "test123")

    visit root_path

    click_link "Log In"

    expect(current_path).to eq("/sessions/new")

    fill_in :email, with: user.email
    fill_in :password, with: "wrong_password"

    click_on "Log In"

    expect(current_path).to eq("/sessions/new")

    expect(page).to have_content("Incorrect email or password")
  end
end