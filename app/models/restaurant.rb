class Restaurant < ApplicationRecord
  belongs_to :city
  has_many :comments
  has_many :chefs, through: :comments

  validates :name, presence: true
  validates :city_id, presence: true

  before_validation :capitalize_cuisine

  def self.by_cuisine(cuisine)
    self.where(cuisine: cuisine.capitalize)
  end

  def capitalize_cuisine
    self.cuisine = self.cuisine.titleize
  end

end
