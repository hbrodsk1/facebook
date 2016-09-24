class User < ApplicationRecord
	has_many :friend_requests, dependent: :destroy
	has_many :pending_friends, through: :friend_requests, source: :friend
	has_many :friendships, dependent: :destroy
	has_many :friends, through: :friendships
  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]


  # devise confirm! method overriden
  #def confirm!
   # welcome_message
    #super
  #end

  def friends_with?(y)
    return true if self.friends.include?(y)
  end

  def remove_friend(friend)
    self.friends.destroy(friend)
  end

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    end 
  end

  private

  def welcome_message
    UserMailer.welcome_email(self).deliver
  end
end
