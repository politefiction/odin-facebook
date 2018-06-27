class FriendshipsController < ApplicationController
    before_action :authenticate_user!

    def create
        @friendship = Friendship.new(friendship_params)
        @friendship.friend = current_user
        if request_received_from?(@friendship.inverse_friend) and @friendship.save
            create_inverse_friendship
            destroy_friend_request(@friendship)
            flash[:success] = "You are now friends with #{@friendship.inverse_friend.first_name}!"
            FriendingMailer.new_friend_email(@friendship.friend, @friendship.inverse_friend).deliver
            redirect_to root_path
        else
            flash[:alert] = "Hmm, something went wrong. Try again?"
            redirect_to friend_requests_path
        end
    end

    def destroy
        @friendship = Friendship.find(params[:id])
        destroy_inverse_friendship(@friendship)
        @friendship.destroy
        flash[:information] = "User unfriended."
        redirect_back(fallback_location: root_url)
    end


    private

    def friendship_params
        params.permit(:inverse_friend_id)
    end

    def create_inverse_friendship
        Friendship.create(friend_id: params[:inverse_friend_id], inverse_friend_id: current_user.id)
    end

    def destroy_friend_request(friendship)
        FriendRequest.where("befriender_id = ? AND befriendee_id = ?", friendship.inverse_friend.id, current_user.id).destroy_all
    end

    def destroy_inverse_friendship(friendship)
        current_user.inverse_friendships.where("inverse_friend_id = ?", friendship.friend).destroy_all
    end

    def request_received_from?(user)
        current_user.received_requests.where("befriender_id = ?", user.id).any?
    end
end
