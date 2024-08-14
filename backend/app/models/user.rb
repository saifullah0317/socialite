class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true

    has_many :friendships
    has_many :friends, through: :friendships, source: :friend

    # def friends
    #     User.joins(:friendships).where(friendships: {user_id: id})
    # end

    validate :cannot_friend_self

    private
    def cannot_friend_self
        errors.add(:base, "You cannot be friend with yourself") if id==friend_id
    end
end
