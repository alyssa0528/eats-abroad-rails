class Restaurant < ApplicationRecord
  belongs_to :city
  has_many :comments
  has_many :chefs, through: :comments

  validates :name, presence: true
  validates :city_id, presence: true

  def comment=(comments)
    comments.each do |content|
      if content != ""
        self.comments.build(content: content)
      end
    end
  end

  def comment
    if self.comments
      self.comments.collect do |comment|
        comment.content
      end
    end 
  end

end
