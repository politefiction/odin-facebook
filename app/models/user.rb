class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, omniauth_providers: %i[facebook]
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :friendships, foreign_key: :inverse_friend_id
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id
  has_many :friends, through: :inverse_friendships
  has_many :inverse_friends, through: :friendships

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name.split[0]
      user.last_name = auth.info.name.split[-1]
      # If you add an image to the User model
      # user.image = auth.info.image
    end
  end
end
