class User < ApplicationRecord
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  # validates :password, confirmation: { case_sensitive: true}
  has_secure_password

  has_many :user_parties
  has_many :parties, through: :user_parties

  enum role: %w(registered admin)

  def self.registered_users
    where(role: 0)
  end
end
