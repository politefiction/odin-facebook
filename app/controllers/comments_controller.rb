class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @parent_id = params.delete(:parent_id)
    @commentable = find_commentable
    @comment = Comment.new(parent_id: @parent_id, commentable_id: @commentable.id, commentable_type: @commentable.class.to_s)
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    if user_or_friend?(@commentable.user)
      if @comment.save
        flash[:notice] = "Successfully created comment."
        redirect_to @commentable
      else
        flash[:error] = "Error adding comment."
      end
    else
      flash[:alert] = "You must be friends with this user to leave comments."
      redirect_to root_url
    end
  end

  def edit
    @commentable = find_commentable
    @comment = Comment.find(params[:id])
  end

  def update
    @commentable = find_commentable
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:notice] = "Successfully edited comment."
      redirect_to @commentable
    else
      flash[:error] = "Error editing comment."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @commentable = find_commentable
    @comment.discard
    flash[:success] = "Comment deleted."
    redirect_to @commentable
  end

  def like_comment
    @comment = Comment.find(params[:id])
    @post = @comment.commentable_type.constantize.find(@comment.commentable_id)
    @like = Like.new(user_id: current_user.id, comment_id: @comment.id)
    if @like.save
      flash[:success] = "You have liked this comment."
    else
      flash[:alert] = @like.errors.full_messages
    end
    redirect_to user_post_path(@post.user, @post)
  end


  private

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def comment_params
    params.require(:comment).permit(:parent_id, :user_id, :content, :commentable_id, :commentable_type)
  end

end
