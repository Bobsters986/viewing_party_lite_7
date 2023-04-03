class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password
  has_secure_password

  has_many :user_parties
  has_many :parties, through: :user_parties
end
