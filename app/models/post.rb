class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 75 }
  validates :body, presence: true, length: { maximum: 4000 }
end
