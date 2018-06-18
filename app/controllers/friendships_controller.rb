class FriendshipsController < ApplicationController
    before_action :authenticate_user!

    def create
        @friendship = Friendship.new(friendship_params)
        if @friendship.save
            create_inverse_friendship
            destroy_friend_request(@friendship)
            flash[:success] = "You are now friends with #{@friendship.inverse_friend.first_name}!"
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
        params.permit(:friend_id, :inverse_friend_id)
    end

    def create_inverse_friendship
        Friendship.create(friend_id: params[:inverse_friend_id], inverse_friend_id: params[:friend_id])
    end

    def destroy_friend_request(friendship)
        FriendRequest.where("befriender_id = ? AND befriendee_id = ?", friendship.inverse_friend.id, current_user.id).destroy_all
    end

    def destroy_inverse_friendship(friendship)
        current_user.inverse_friendships.where("inverse_friend_id = ?", friendship.friend).destroy_all
    end
end
