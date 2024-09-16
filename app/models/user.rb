class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :sorted_by_wins, -> { order(wins: :desc) }

  has_many :games
  has_many :players
  has_many :friendships
  has_many :users, through: :friendships

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
