class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @feed = []
    current_user.friends.map do |friend|
      friend.posts.map { |post| @feed << post }
    end
    @feed.sort_by!(&:created_at).reverse!
  end
end
