class Comment < ApplicationRecord
  include Discard::Model
  
  belongs_to :user
  has_ancestry
  has_many :likes, dependent: :destroy
  validates :content, presence: true, length: { maximum: 2000 }
end
