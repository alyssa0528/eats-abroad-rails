class ChefsController < ApplicationController
  before_action :find_chef, only: [:show, :edit, :update]

  #GET /chefs/new (show signup form)
  def new
    @chef = Chef.new
  end

  #POST /chefs (create new chef user)
  def create
    @chef = Chef.new(chef_params)
    #binding.pry
    if @chef.save
      session[:email] = @chef.email
      redirect_to root_path
    else
      render :new
    end

  end

  #GET /chefs/:id
  def show
  end

  def edit
    if @chef.email != session[:email]
      redirect_to chef_path(current_user)
    end
  end

  def update
    @chef.update(chef_params)
    redirect_to chef_path(@chef)
  end

  private

  def chef_params
    params.require(:chef).permit(:name, :email, :password, :uid, :hometown, :employer)
  end

  def find_chef
    @chef = Chef.find(params[:id])
  end
end
