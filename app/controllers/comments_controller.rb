class CommentsController < ApplicationController
  def create

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
end
