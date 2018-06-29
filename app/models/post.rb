class Post < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 75 }
  validates :body, presence: true, length: { maximum: 4000 }
end
