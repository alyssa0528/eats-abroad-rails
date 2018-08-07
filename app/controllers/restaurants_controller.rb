class RestaurantsController < ApplicationController

  #GET /restaurants (account for nested route and plain /restaurants route)
  def index
    if params[:city_id]
      @restaurants = City.find(params[:city_id]).restaurants
    elsif params[:chef_id]
      @restaurants = Chef.find(params[:chef_id]).restaurants
    else
      @restaurants = Restaurant.all
    end
  end

  #GET /restaurants/:id
  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new 
  end
end
