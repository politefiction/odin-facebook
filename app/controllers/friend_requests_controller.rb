class FriendRequestsController < ApplicationController
    before_action :authenticate_user!

    def index
        @friend_requests = current_user.received_requests
    end

    def create
        @friend_request = FriendRequest.new(friend_request_params)
        @friend_request.befriender = current_user
        if @friend_request.save
            flash[:success] = "Friend request has been sent."
            FriendingMailer.fr_email(@friend_request.befriendee, @friend_request.befriender).deliver
        else
            flash[:alert] = "Request failed. Try again?"
        end
        redirect_back(fallback_location: user_path(params[:befriendee_id]))
    end

    def destroy
        @friend_request = FriendRequest.find(params[:id])
        @friend_request.destroy
        flash[:success] = "Request ignored."
        redirect_to friend_requests_path
    end

    private
    
    def friend_request_params
        params.permit(:befriender_id, :befriendee_id)
    end
end
