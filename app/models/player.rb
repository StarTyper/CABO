class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :user_id, presence: true
  validates :game_id, presence: true
  validates :player_id, presence: true, inclusion: { in: [1, 2, 3, 4, 5] }
  validates :score, presence: true
end
