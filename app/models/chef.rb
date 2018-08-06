class Chef < ApplicationRecord
  has_many :comments
  has_many :restaurants, through: :comments

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true
  has_secure_password
end
