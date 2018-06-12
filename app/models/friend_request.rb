class FriendRequest < ApplicationRecord
    belongs_to :befriender, class_name: "User"
    belongs_to :befriendee, class_name: "User"
    validates :befriender_id, presence: true
    validates :befriendee_id, presence: true
end
