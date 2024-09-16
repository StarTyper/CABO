class Card < ApplicationRecord
  has_many :game_cards

  validates :number, presence: true, inclusion: { in: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13] }
  validates :specialty, presence: true, inclusion: { in: %w[none peek spy swap] }
end
