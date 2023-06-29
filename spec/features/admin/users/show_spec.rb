require "rails_helper"

describe "Admin Users Dashboard", :vcr do
  before(:each) do
    @admin = create(:user, password: "Admin123", role: 1)

    @stan = User.create!(name: "Stan Johnson", email: "stan@example.com", password: "test123")
    @ben = create(:user, password: "test124")
    @sarah = create(:user, password: "test125")
    @jill = create(:user, password: "test126")

    @my_party = create(:party, host_id: @stan.id, movie_id: 550, day: "2023-03-26", time: "20:00")
    @their_party = create(:party, host_id: @ben.id, movie_id: 550, day: "2023-03-31", time: "19:00")

    UserParty.create!(user_id: @stan.id, party_id: @my_party.id)
    UserParty.create!(user_id: @ben.id, party_id: @my_party.id)
    UserParty.create!(user_id: @sarah.id, party_id: @my_party.id)
    UserParty.create!(user_id: @jill.id, party_id: @my_party.id)

    UserParty.create!(user_id: @stan.id, party_id: @their_party.id)
    UserParty.create!(user_id: @ben.id, party_id: @their_party.id)
    UserParty.create!(user_id: @sarah.id, party_id: @their_party.id)
    UserParty.create!(user_id: @jill.id, party_id: @their_party.id)
  end

  context "As an Admin, when I visit a users dashboard page" do
    it "I will see their viewing parties details, details of viewing parties they are invited to, and the movie title and img" do
      visit root_path
      log_in(@admin)

      click_link @stan.email
      expect(current_path).to eq(admin_user_path(@stan))

      within "#party-#{@my_party.id}" do
        expect(page).to have_css("img")
        expect(page).to have_link("Fight Club")
        expect(page).to have_content("Date: March 26, 2023")
        expect(page).to have_content("Time: 08:00 PM")
        expect(page).to have_content("Host: #{@stan.name}")
        within "ul#guests" do
          expect(page).to have_content("#{@ben.name}")
          expect(page).to have_content("#{@sarah.name}")
          expect(page).to have_content("#{@jill.name}")
        end
      end

      within "#party-#{@their_party.id}" do
        expect(page).to have_css("img")
        expect(page).to have_link("Fight Club")
        expect(page).to have_content("Date: March 31, 2023")
        expect(page).to have_content("Time: 07:00 PM")
        expect(page).to have_content("Host: #{@ben.name}")
        within "ul#guests" do
          expect(page).to have_content("#{@stan.name}")
          expect(page).to have_content("#{@sarah.name}")
          expect(page).to have_content("#{@jill.name}")
        end
      end
    end
  end

  context "As a User or visitor" do
    it "I cannot visit the admin users dashboard" do
      visit admin_user_path(@stan)

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You must be an admin to view this page")
      
      visit root_path
      log_in(@ben)

      visit admin_user_path(@stan)

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You must be an admin to view this page")
    end
  end
end