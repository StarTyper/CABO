class Game < ApplicationRecord
  belongs_to :user
  has_many :players
  has_many :game_cards

  validates :user_id, presence: true
  validates :player_count, presence: { message: 'is mandatory, please specify from 2-5' }, inclusion: { in: [2, 3, 4, 5] }
  validates :name, presence: true
end
