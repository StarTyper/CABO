class Friendship < ApplicationRecord
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'

  validates :user1_id, presence: true
  validates :user2_id, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending accepted declined] }
end
