class ChefsController < ApplicationController

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

  private

  def chef_params
    params.require(:chef).permit(:name, :email, :password_digest, :uid, :hometown, :employer)
  end
end
