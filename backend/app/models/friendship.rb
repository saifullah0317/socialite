class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :not_self
  validate :unique_friendship

  private
  
  def not_self
    errors.add(:friend_id, "can't be friends with self") if user_id = friend_id
  end

  def unique_friendship
    if Friendship.where(user_id: user_id, friend_id: friend_id).exists? || Friendship.where(user_id: friend_id, friend_id: user_id).exists?
      errors.add(:base, "Friendship already exists")
    end
  end
end