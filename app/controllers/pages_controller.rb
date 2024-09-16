class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :landing ]

  def home
    @games = Game.where(current_user == :user)
    @friendships = Friendship.where(user1_id: current_user.id).or(Friendship.where(user2_id: current_user.id))
  end

  def landing
    @wins = User.sorted_by_wins
  end
end
