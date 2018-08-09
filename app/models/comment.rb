class Comment < ApplicationRecord
  belongs_to :chef
  belongs_to :restaurant

  validates :content, length: {minimum: 10}
end
