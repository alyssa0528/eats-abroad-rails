class RestaurantsController < ApplicationController

  #GET /restaurants (account for nested route and plain /restaurants route)
  def index
    if params[:city_id]
      @restaurants = City.find(params[:city_id]).restaurants
      @city = City.find(params[:city_id])
    elsif params[:chef_id]
      @restaurants = Chef.find(params[:chef_id]).restaurants
      @chef = Chef.find(params[:chef_id])
    else
      @restaurants = Restaurant.all
    end
  end

  #GET /restaurants/:id
  def show
    @restaurant = Restaurant.find(params[:id])
  end

  #GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  #POST
  def create
    #for creating brand new restaurant
    #binding.pry
    @new_restaurant = current_user.restaurants.build(restaurant_params)
    @new_restaurant.save
    redirect_to restaurant_path(@new_restaurant)
    #if Restaurant.find(params[:restaurant][:id]) #if the restaurant was selected from drop-down
    #  @restaurant = Restaurant.find(params[:restaurant][:id])
    #  binding.pry
    #if @restaurant.save
    #  @restaurant.save
    #  redirect_to chef_restaurant(@restaurant)
    #else
    #  render :new
    #end
    binding.pry
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:name, :cuisine, :city_id, :comments => [])
  end

end
