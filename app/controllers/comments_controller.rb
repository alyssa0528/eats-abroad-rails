class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update]

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comments_params)

    if @comment
      @comment.save
      redirect_to restaurant_path(@comment.restaurant)
    else
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
    params.require(:comments).permit(content: [])
  end
end
