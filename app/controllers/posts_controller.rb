class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
  end

  def show
    @comment = Comment.new # for the inline comment form on the show page
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    # If you add authentication later (e.g., Devise), replace with:
    # @post.user = current_user
    @post.user ||= User.first # fallback for dev/demo

    if @post.save
      redirect_to @post, notice: "Post created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  # Permit :user_id for now (no auth). If you add Devise, drop :user_id and set @post.user = current_user
  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end
