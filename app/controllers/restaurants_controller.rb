class RestaurantsController < ApplicationController

  #GET /restaurants (account for nested route and plain /restaurants route)
  def index
    if params[:city_id]
      @restaurants = City.find(params[:city_id]).restaurants
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
    @restaurant = Restaurant.new(restaurant_params)

    if @restaurant.save
      @restaurant.save
      redirect_to chef_restaurant(@restaurant)
    else
      render :new
    end
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:name, :cuisine, :city_id)
  end

end
