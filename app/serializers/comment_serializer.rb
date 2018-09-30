class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :chef

  belongs_to :chef
  belongs_to :restaurant
end
