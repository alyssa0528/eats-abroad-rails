class Restaurant < ApplicationRecord
  belongs_to :city
  has_many :comments
  has_many :chefs, through: :comments

  validates :name, presence: true
  validates :city_id, presence: true
  
end
