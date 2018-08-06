class RestaurantsController < ApplicationController
  def index
    if params[:city_id]
      @restaurants = City.find(params[:city_id]).restaurants
    else
      @restaurants = Restaurant.all
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end
end
