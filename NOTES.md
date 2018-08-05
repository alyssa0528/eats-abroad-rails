City:
has_many :restaurants

****

Comment (JOIN TABLE):
belongs_to :chef
belongs_to :restaurant

validates :content, length: 10 characters min.

****

Restaurant:
belongs_to :city
has_many :comments
has_many :chefs, through: :comments

validates :name, presence: true

****

Chef:
has_many :comments
has_many :restaurants, through: :comments

validates :name, presence: true
validates :email, uniqueness: true

****

Class scope:
.most_popular: returns list of most popular restaurants based on number of associated chefs/comments

****

Nested resource:
/chefs/1/restaurants => lists all restaurants recommended by chef 1
/chefs/1/restaurants/new => allows chef 1 to add a new restaurant 
