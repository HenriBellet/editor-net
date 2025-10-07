class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :authorize_owner!,    only: %i[edit update destroy]

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
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: 'Post created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post deleted.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  # Permit :user_id for now (no auth). If you add Devise, drop :user_id and set @post.user = current_user
  def post_params
    params.require(:post).permit(:title, :content, :video, :user_id)
  end

  def authorize_owner!
    redirect_to @post, alert: 'Not authorized.' unless @post.user == current_user
  end
end
