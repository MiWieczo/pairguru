class CommentsController < ApplicationController
  def create
    @comment = Comment.new(text: params[:comment][:text], movie_id: params[:movie_id], author_id: current_user.id)
    if @comment.save
      redirect_to movie_path(@comment.movie), notice: "New comment was successfully created"
    else
      redirect_to movie_path(@comment.movie), alert: "Something went wrong with submitting the comment"
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

  def comment_params
    params.permit(:movie_id)
  end
end
