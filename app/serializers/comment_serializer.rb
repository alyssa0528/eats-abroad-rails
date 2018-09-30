class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content

  belongs_to :chef
  belongs_to :restaurant
end
