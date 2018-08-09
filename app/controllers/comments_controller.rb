class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update]

  def new
    @comment = Comment.new
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def create
    @comment = Comment.new
    @restaurant = Restaurant.find(params[:restaurant_id])
    
    @comment = current_user.comments.build(comments_params)
    @comment.restaurant_id = params[:restaurant_id]
    if @comment.save #if it can save to DB successfully
      redirect_to restaurant_path(@comment.restaurant)
    else #if there are errors, render new form
      render :new
    end

  end

  def edit
  end

  def update
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def comments_params
    params.require(:comment).permit(:content)
  end
end
