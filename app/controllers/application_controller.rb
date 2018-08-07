class ApplicationController < ActionController::Base
  def home
    #binding.pry
    @chef = Chef.find_by(:email => session[:email])
  end
end
