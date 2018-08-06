class ChefsController < ApplicationController
  before_action :find_chef, only: [:show]

  #GET /chefs/new (show signup form)
  def new
    @chef = Chef.new
  end

  #POST /chefs (create new chef user)
  def create
    @chef = Chef.new(chef_params)

    if @chef.save 
      redirect_to chef_path(@chef)
    else
      render :new #have error messages appear
    end

  end

  #GET /chefs/:id
  def show
  end

  private

  def chef_params
    params.require(:chef).permit(:name, :email, :password, :uid, :hometown, :employer)
  end

  def find_chef
    @chef = Chef.find(params[:id])
  end
end
