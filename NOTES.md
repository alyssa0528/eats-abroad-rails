City:
has_many :restaurants

Schema:
name:string

****

Comment (JOIN TABLE):
belongs_to :chef
belongs_to :restaurant

validates :content, length: 10 characters min.

Schema:
content:text
chef_id:integer
restaurant_id:integer

****

Restaurant:
belongs_to :city
has_many :comments
has_many :chefs, through: :comments

validates :name, presence: true

Schema:
name:string
cuisine:string
city_id:integer

****

Chef:
has_many :comments
has_many :restaurants, through: :comments

validates :name, presence: true
validates :email, uniqueness: true

Schema:
name:string
email:string
password_digest:string

****

Class scope:
.most_popular: returns list of most popular restaurants based on number of associated chefs/comments

****

Nested resource:
/chefs/1/restaurants => lists all restaurants recommended by chef 1
/chefs/1/restaurants/new => allows chef 1 to add a new restaurant
