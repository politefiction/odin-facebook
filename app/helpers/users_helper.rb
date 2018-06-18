module UsersHelper
    def find_friendship(friend)
        friendship = current_user.friendships.where("friend_id = ?", friend)
        friendship.first
    end
end
