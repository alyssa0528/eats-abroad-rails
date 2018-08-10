class RestaurantsController < ApplicationController
  before_action :require_login

  #GET /restaurants (account for nested route and plain /restaurants route)
  def index
    if params[:type]
      #find restaurants with this cuisine type
      @restaurants = Restaurant.by_cuisine(params[:type])
    elsif params[:city_id]
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
    @chef = current_user
    @restaurant = Restaurant.new
  end

  #POST
  def create
    @chef = current_user
    @restaurant = Restaurant.new

    #to handle existing restaurant addition
    if params[:restaurant][:id] #will have id from dropdown
      @restaurant = Restaurant.find(params[:restaurant][:id]) #find the restaurant instance
      redirect_to new_restaurant_comment_path(@restaurant) #go to that restaurant's comments page

    #to handle brand new restaurant addition
    elsif params[:restaurant][:name] != "" && params[:restaurant][:city_id] != ""
      #if name and city ID are provided (required per validations)
      if Restaurant.find_by(:name => params[:restaurant][:name]) # if name matches existing an restaurant
        @restaurant = Restaurant.find_by(:name => params[:restaurant][:name]) #find the instance, assign to @restaurant
        redirect_to new_restaurant_comment_path(@restaurant) #go to new comment page
      else  #if it's a brand new restaurant not in the database
        @new_restaurant = current_user.restaurants.build(restaurant_params)
        if @new_restaurant.save
          redirect_to new_restaurant_comment_path(@new_restaurant)
        else
          render :new
        end
      end
      #to handle a brand new restaurant addition with missing required fields
    elsif params[:restaurant][:name] == "" || params[:restaurant][:city_id] == ""
      @restaurant = Restaurant.new(restaurant_params) #this won't save because it's missing a required field
      if !@restaurant.save
        render :new
        @chef = current_user
      end
    end
  end

private

  def restaurant_params
    params.require(:restaurant).permit(:name, :cuisine, :city_id)
  end

  def require_login
    return head(:forbidden) unless session.include? :email
  end

end
