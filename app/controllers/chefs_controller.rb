class ChefsController < ApplicationController
  before_action :find_chef, only: [:show]

  #action for signup form
  def new
    @chef = Chef.new
  end

  #post action for signup
  def create
    @chef = Chef.new(chef_params)

    if @chef
      redirect_to chef_path(@chef)
    else
      render :new
    end

  end

  def show
  end

  private

  def chef_params
    params.require(:chef).permit(:name, :email, :password_digest, :uid, :hometown, :employer)
  end

  def find_chef
    @chef = Chef.find(params[:id])
  end
end
