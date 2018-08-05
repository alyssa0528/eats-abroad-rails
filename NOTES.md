City:
has_many :restaurants

Schema:
name:string

Paths:
/cities => lists all the cities
/cities/:id => shows a specific city and its restaurants (could also make this nested, i.e. /cities/:id/restaurants)

allow new/create option...?

edit, update, delete not needed for City

****

Comment (JOIN TABLE):
belongs_to :chef
belongs_to :restaurant

validates :content, length: 10 characters min.

Schema:
content:text
chef_id:integer
restaurant_id:integer

Paths/Actions:
/comments/create => create new comment
/comments/edit => edit a comment
/comments/update => update a comment
/comments/delete => delete a comment

comments by itself won't have index or show. would be nested under restaurants and/or chefs
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

Paths:
restaurants/new => chef adds new restaurant to his recommended list, as well as a comment for it here
restaurants/:id => restaurant's show page
/restaurants/:id/comments => index of comments for a particular restaurant

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
uid:string (for oauth)

get chefs/new => signup
chefs/edit ? => chef can edit their profile
chefs/:id => chef's profile page showing name, hometown, and restaurant
chefs/:id/restaurants => shows all restaurants recommended by a particular chef

****

Class scope:
.most_popular: returns list of most popular restaurants based on number of associated chefs/comments

****

Nested resource:
/chefs/1/restaurants => lists all restaurants recommended by chef 1
/chefs/1/restaurants/new => allows chef 1 to add a new restaurant
