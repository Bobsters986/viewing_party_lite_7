require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :user_parties }
    it { should have_many :parties }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }

    describe "Password security" do
      it "can create a user's password securely" do
        user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')
        expect(user).to_not have_attribute(:password)
        expect(user.password_digest).to_not eq('password123')
      end
    end

    describe "::class methods" do
      it "::registered_users, returns a list of only registered users" do
        admin = create(:user, password: "Admin123", role: 1)

        user_1 = create(:user, password: "test123")
        user_2 = create(:user, password: "test234")
        user_3 = create(:user, password: "test345")

        expect(User.registered_users).to eq([user_1, user_2, user_3])
      end
    end
  end
end
