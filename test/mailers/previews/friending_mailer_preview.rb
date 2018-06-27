# Preview all emails at http://localhost:3000/rails/mailers/friending_mailer
class FriendingMailerPreview < ActionMailer::Preview
    def fr_email_preview
        FriendingMailer.fr_email(User.first, User.second)
    end

    def new_friend_email_preview
        FriendingMailer.new_friend_email(User.first, User.second)
    end
end
