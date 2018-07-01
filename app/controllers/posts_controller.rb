class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = User.find(params[:user_id]).posts
    unless user_or_friend?
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
      flash[:alert] = "Hmm, something went wrong. Try again?"
      redirect_to new_user_post_path
    end
  end

  def show
    @post = Post.find(params[:id])
    unless user_or_friend?
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
      flash[:alert] = "Hmm, something went wrong. Try again?"
      edit_user_post(@post)
    end
  end

  def destroy
  end


  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def user_or_friend?
    user = User.find(params[:user_id])
    (current_user == user) or (user.friends.include? current_user)
  end
end
