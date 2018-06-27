class FriendingMailer < ApplicationMailer

    def fr_email(befriendee, befriender)
        @befriendee = befriendee
        @befriender = befriender
        mail(to: @befriendee.email, subject: 'You have a friend request!')
    end

    def new_friend_email(friend, inverse_friend)
        @friend = friend
        @inverse_friend = inverse_friend
        mail(to: @inverse_friend.email, subject: "You are now friends with #{friend.first_name}!")
    end
end
