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
    if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to @commentable
    else
      flash[:error] = "Error adding comment."
    end
  end

  def edit
  end

  def update
  end

  def delete
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
