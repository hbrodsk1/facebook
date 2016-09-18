class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :not_self

  def accept
  	user.friends << friend
  	create_inverse_friendship
  	friend.friends << user

  	destroy
  end

  def create_inverse_friendship
  	Friendship.new(user_id: friend.id, friend_id: user.id)
  end

  private

  def not_self
    if user_id == friend_id 
      errors.add(:friend, "can't be equal to user")
    end
  end

end
