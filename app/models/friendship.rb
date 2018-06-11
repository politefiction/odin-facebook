class Friendship < ApplicationRecord
    belongs_to :friend, class_name: "User"
    belongs_to :inverse_friend, class_name: "User"
    validates :friend_id, presence: true
    validates :inverse_friend_id, presence: true
end
