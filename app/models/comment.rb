class Comment < ApplicationRecord
  belongs_to :user
  has_ancestry
  validates :content, presence: true, length: { maximum: 2000 }
end
