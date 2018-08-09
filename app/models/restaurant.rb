class Restaurant < ApplicationRecord
  belongs_to :city
  has_many :comments
  has_many :chefs, through: :comments

  validates :name, presence: true
  validates :city_id, presence: true

  #accepts_nested_attributes_for :comments

  def self.by_cuisine(cuisine)
    binding.pry
    self.where(cuisine: cuisine.capitalize)
  end

  #def comment_ids(ids)
  #  ids.each do |id|
  #    id = Comment.find(id)
  #    self.comments << id
  #  end
  #end

  #def comment_ids
  #  if self.comments
  #    self.comments.each do |comment|
  #      comment.content
  #    end
  #  else
  #    nil
  #  end
  #end

  #def comment_contents=(comment_array)
  #  self.save #save the newly created restaurant
  #  comment_array.each do |content|
  #    binding.pry
  #    if content.strip != ''
  #      c = self.comments.build(content: content)
  #      c.save
  #    end
  #  end
  #end
#
  #def comment_contents
  #  if self.comments
  #    self.comments.collect do |comment|
  #      comment.content
  #    end
  #  else
  #    nil
  #  end
  #end

  def self.most_popular
    binding.pry
    self.group('comments').order('count_all').limit(1).count
  end



end
