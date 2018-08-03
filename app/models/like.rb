class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  validates :user, presence: true
  validate :post_xor_comment
  validate :unique_like

  private

  def post_xor_comment
    unless post.blank? ^ comment.blank?
      errors.add(:base, "Like must be attached to a post or comment")
    end
  end

  def unique_like
    if Like.where("user_id = ? AND post_id = ?", user_id, post_id).any?
      errors.add(:base, "You've already liked this post.")
    elsif Like.where("user_id = ? AND comment_id = ?", user_id, comment_id).any?
      errors.add(:base, "You've already liked this comment.")
    end
  end
end
