class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def friends_list
    @friends = current_user.friends
  end

end
