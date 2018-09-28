class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :cuisine

  belongs_to :city
  has_many :comments
  has_many :chefs, through: :comments
end
