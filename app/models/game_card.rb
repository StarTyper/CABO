class GameCard < ApplicationRecord
  belongs_to :card
  belongs_to :game
  has_many :players, through: :game

  validates :game_id, presence: true
  validates :card_id, presence: true
  validates :position, presence: true, inclusion: { in: [1, 2, 3, 4, 5, 6, 7, 8] }
end
