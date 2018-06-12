class FriendshipsController < ApplicationController
    before_action :authenticate_user!

    def new
    end

    def create
        # create friendship
        # create inverse friendship
    end

    def destroy
        # unfriend, basically
    end

    private

    def friendship_params
        params.require(:friendship).permit(:friend_id, :inverse_friend_id)
    end
end
