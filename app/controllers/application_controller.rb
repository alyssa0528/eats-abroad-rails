class ApplicationController < ActionController::Base
  include ApplicationHelper
  
  def home
    #binding.pry
    @chef = Chef.find_by(:email => session[:email])
  end
end
