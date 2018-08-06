class SessionsController < ApplicationController

  #/signin
  def new
  end

  #post /signin
  def create
    if params[:email]
      @chef = Chef.find_by(:email => params[:email])

      if @chef && @chef.authenticate(params[:password])
        #raise params.inspect
        session[:user_id] = @chef.id
        #binding.pry
        redirect_to root_path
      else
        render :new
      end
    elsif auth['email']
      @chef = Chef.find_or_create_by(email: auth['email']) do |c|
        c.name = auth['info']['name']
        #c.email = auth['info']['email']
      end

      session[:user_id] = @chef.id

      render 'application/home'
    end
  end

  #post /logout
  def destroy
    session.delete :email
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
