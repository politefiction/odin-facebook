class PostsController < ApplicationController
  include Commentable
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    unless user_or_friend?(@user)
      flash[:notice] = "You must be friends with a user to view their posts."
      redirect_to root_url
    end
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created."
      redirect_to user_posts_path(current_user)
    else
      flash[:alert] = @post.errors.full_messages
      redirect_to new_user_post_path
    end
  end

  def show
    @post = Post.find(params[:id])
    unless user_or_friend?(@post.user)
      flash[:notice] = "You must be friends with a user to view their posts."
      redirect_to root_url
    end
  end

  def edit
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated."
      redirect_to user_post_path(@post.user, @post)
    else
      flash[:alert] = @post.errors.full_messages
      edit_user_post(@post)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "Post deleted."
    redirect_back(fallback_location: root_url)
  end

  def like_post
    @post = Post.find(params[:id])
    @like = Like.new(user_id: current_user.id, post_id: @post.id)
    if @like.save
      flash[:success] = "You have liked this post."
    else
      flash[:alert] = @like.errors.full_messages
    end
    redirect_to user_post_path(@post.user, @post)
  end


  private

  def post_params
    params.require(:post).permit(:title, :body)
  end


end
