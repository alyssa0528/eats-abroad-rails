class SessionsController < ApplicationController

  #/signin
  def new
  end

  #post /signin
  def create
    @chef = Chef.find_by(:email => params[:email])

    if @chef && @chef.authenticate(params[:password])
      session[:email] = params[:email]
      redirect_to root_path
    else
      render :new
    end
  end

  #post /logout
  def destroy
    session.delete :email
    redirect_to root_path
  end

end
