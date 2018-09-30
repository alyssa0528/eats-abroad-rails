class ChefSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :comments
  has_many :restaurants
end
