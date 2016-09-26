class Post < ApplicationRecord
  validates :content, presence: true

  belongs_to :user
  has_many :likes
  has_many :liking_users, through: :likes, source: :user
  has_many :comments
end
