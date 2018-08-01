class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  validates :user, presence: true
  validate :post_xor_comment

  private

  def post_xor_comment
    unless post.blank? ^ comment.blank?
      errors.add(:base, "Like must be attached to a post or comment")
    end
  end
end
