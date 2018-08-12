class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, omniauth_providers: %i[facebook]

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :friendships, foreign_key: :inverse_friend_id, dependent: :destroy
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friends, through: :inverse_friendships

  has_many :received_requests, class_name: "FriendRequest", foreign_key: :befriendee, dependent: :destroy
  has_many :sent_requests, class_name: "FriendRequest", foreign_key: :befriender, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :nullify
  has_many :likes, dependent: :nullify

  #has_one_attached :avatar

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name.split[0]
      user.last_name = auth.info.name.split[-1]
      user.image = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.image = data["image"] if user.image.blank?
      end
    end
  end
end
