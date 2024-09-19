class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :sorted_by_wins, -> { order(wins: :desc) }

  has_many :games
  has_many :players

  # Associations for friendships
  has_many :friendships_as_user1, class_name: 'Friendship', foreign_key: 'user1_id'
  has_many :friendships_as_user2, class_name: 'Friendship', foreign_key: 'user2_id'

  has_many :friends_as_user1, through: :friendships_as_user1, source: :user2
  has_many :friends_as_user2, through: :friendships_as_user2, source: :user1

  # This combines both directions
  def all_friends
    friends_as_user1 + friends_as_user2
  end

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :username, presence: true, uniqueness: true

  include PgSearch::Model
  pg_search_scope :search_by_username,
    against: [:username],
    using: {
      tsearch: { prefix: true } # <-- this allows partial matching
    }
end
