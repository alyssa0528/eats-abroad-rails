class ApplicationController < ActionController::Base
  include ApplicationHelper

  def home
    #binding.pry
    @chef = Chef.find_by(:email => session[:email])
    if !@chef
      render :layout => false
    end 
  end
end
