class FriendRequest < ApplicationRecord
    belongs_to :befriender, class_name: "User"
    belongs_to :befriendee, class_name: "User"
    validates :befriender_id, presence: true
    validates :befriendee_id, presence: true
    validate :not_friending_self

    def not_friending_self
        if befriendee_id == befriender_id
            errors.add(:befriender_id, "user cannot friend itself")
        end
    end
end
