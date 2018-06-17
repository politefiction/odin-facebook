class FriendRequestsController < ApplicationController
    before_action :authenticate_user!

    def index
        @friend_requests = current_user.received_requests
    end

    def create
        @friend_request = FriendRequest.new(friend_request_params)
        if @friend_request.save
            flash[:success] = "Friend request has been sent."
            # should incorporate mailer later
        else
            flash[:alert] = "Request failed. Try again?"
        end
        redirect_back(fallback_location: root_url)
    end

    def destroy
        @friend_request = FriendRequest.find(params[:id])
        @friend_request.destroy
        flash[:success] = "Request ignored."
        redirect_back(fallback_location: root_url)
    end

    private
    
    def friend_request_params
        params.require(:friend_request).permit(:befriender_id, :befriendee_id)
    end
end
