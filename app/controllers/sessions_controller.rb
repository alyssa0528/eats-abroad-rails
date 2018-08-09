class SessionsController < ApplicationController

  #/signin
  def new
  end

  #post /signin
  def create
    if params[:email]
      @chef = Chef.find_by(:email => params[:email])

      if @chef && @chef.authenticate(params[:password])
        session[:email] = @chef.email
        redirect_to root_path
      else
        render :new
      end
    elsif auth[:info][:email]
      @chef = Chef.find_or_create_by(email: auth[:info][:email]) do |c|
        c.name = auth['info']['name']
        c.uid = auth[:uid]
        c.password = 'password'
      end

      session[:email] = @chef.email

      render 'application/home'
    end
  end

  #post /logout
  def destroy
    session.delete(:email)
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
