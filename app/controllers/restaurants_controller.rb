class RestaurantsController < ApplicationController
  before_action :require_login

  #GET /restaurants (account for nested route and plain /restaurants route)
  def index
    if params[:type]
      #find restaurants with this cuisine type
      @restaurants = Restaurant.by_cuisine(params[:type])
    elsif params[:city_id]
      @city = City.find(params[:city_id])
      @restaurants = @city.restaurants
    elsif params[:chef_id]
      @chef = Chef.find(params[:chef_id])
      @restaurants = @chef.restaurants
    else
      @restaurants = Restaurant.all
      respond_to do |f|
        f.html
        f.json {render json: @restaurants}
      end
    end
  end

  #GET /restaurants/:id
  def show
    @restaurant = Restaurant.find(params[:id])

    respond_to do |f|
      f.html
      f.json {render json: @restaurant}
    end
  end

  def search
    redirect_to "/restaurants/cuisine/#{params[:search]}"
    #binding.pry
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
          respond_to do |format|
            format.html {redirect_to new_restaurant_comment_path(@new_restaurant)} #go to that restaurant's comments page
            format.js { }
          end
          #redirect_to new_restaurant_comment_path(@new_restaurant)
        else
          render :new
        end
      end
      #to handle a brand new restaurant addition with missing required fields
    elsif params[:restaurant][:name] == "" || params[:restaurant][:city_id] == ""
      @restaurant = Restaurant.new(restaurant_params) #this won't save because it's missing a required field
      if !@restaurant.save
        render :new
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
