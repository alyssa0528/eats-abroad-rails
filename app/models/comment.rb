class Comment < ApplicationRecord
  belongs_to :chef
  belongs_to :restaurant

  validates_length_of :content, :minimum => 10
end
