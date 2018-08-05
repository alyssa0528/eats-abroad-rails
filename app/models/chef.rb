class Chef < ApplicationRecord
  has_many :comments
  has_many :restaurants, through: :comments

  validates :name, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
end
