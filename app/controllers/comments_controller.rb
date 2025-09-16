class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)

    # With auth, use current_user; for now allow param or default
    @comment.user ||= User.first

    if @comment.save
      redirect_to @post, notice: "Comment added."
    else
      # Render the post show with validation errors
      @comments = @post.comments.includes(:user).order(created_at: :asc)
      render "posts/show", status: :unprocessable_entity
    end
  end

  def destroy
    comment = @post.comments.find(params[:id])
    comment.destroy
    redirect_to @post, notice: "Comment deleted."
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id)
  end
end
