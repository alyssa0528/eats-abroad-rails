class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update]

  def new
    @comment = Comment.new
    @restaurant = Restaurant.find(params[:restaurant_id])
    if @restaurant.comments.length != 0
      @comments = Comment.where(restaurant_id: params[:restaurant_id])
    end
  end

  def create
    @comment = Comment.new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = current_user.comments.build(comments_params)
    @comment.restaurant_id = params[:restaurant_id]

    if @comment.save #if it can save to DB successfully
      render 'comments/show', :layout => false
    else #if there are errors, render new form
      # @comments = @restaurant.comments
      render :new
    end
  end

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comments = @restaurant.comments
    respond_to do |f|
      f.html
      f.json {render json: @comments}
    end
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comments_params
    params.require(:comment).permit(:content)
  end
end
