class User < ApplicationRecord
	has_many :friend_requests, dependent: :destroy
	has_many :pending_friends, through: :friend_requests, source: :friend
	has_many :friendships, dependent: :destroy
	has_many :friends, through: :friendships
  has_many :posts, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def friends_with?(y)
    return true if self.friends.include?(y)
  end

  def remove_friend(friend)
    self.friends.destroy(friend)
  end

#  def cook?(friend)
#      self.friend_requests.each do |request|
#        return true if request.friend_id == friend.id
#      end
#  end
end
