class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update]

  def new
    @comment = Comment.new
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def create
    #binding.pry
    @comment = current_user.comments.build(comments_params)
    @comment.restaurant_id = params[:restaurant_id]
    binding.pry
    if @comment.errors.any?
      render :new
    else
      @comment.save
      redirect_to restaurant_path(@comment.restaurant)
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
