class SessionsController < ApplicationController

  #/signin
  def new
  end


  def create
    @user = User.find_by(:email => params[:email])

    if @user && @user.authenticate(params:password)
      session[:email] = params[:email]
      redirect_to root_path
    else
      render :new
    end 
  end

end
