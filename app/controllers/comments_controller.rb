class CommentsController < ApplicationController
  before_action :permit_params, only: :create

  def create
    if current_user.is_allowed_to_add_comment
      @comment = Comment.new(text: params[:comment][:text], movie_id: params[:movie_id], author_id: current_user.id)
      if @comment.save
        redirect_to movie_path(@comment.movie), notice: "New comment was successfully created"
      else
        redirect_to movie_path(@comment.movie), alert: "Something went wrong with submitting the comment"
      end
    else
      redirect_to movie_path(params[:movie_id]), alert: "You have to delete your previous comment first"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.author == current_user
      @comment.destroy
      redirect_to movie_path(@comment.movie), notice: "Comment was successfully deleted"
    else
      redirect_to movie_path(@comment.movie), alert: "You cannot perform this action"
    end
  end

  def permit_params
    params.permit(:movie_id, :comment)
  end
end
