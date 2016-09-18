class Friendship < ApplicationRecord
  #after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  belongs_to :user
  belongs_to :friend, class_name: "User"

  validate :not_self

  

  def create_inverse_relationship
    #byebug
  	friend.friendships.build(friend_id: user.id)

  end

  def destroy_inverse_relationship
  	friendship = friend.friendships.find_by(friend: user)
  	friendship.destroy if friendship
  end

  private

  def not_self
    if user_id == friend_id 
      errors.add(:friend, "can't be equal to user")
    end  
  end
end
