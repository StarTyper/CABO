class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :landing ]

  def home
    @user = current_user
    @players = Player.where(user: current_user)

    @games = Game.where(players: @players).where.not(user: current_user)

    @mygames = Game.where(user: current_user).order(created_at: :desc)

    @friendships = Friendship.where(user1_id: current_user.id).or(Friendship.where(user2_id: current_user.id))
  end

  def landing
    @wins = User.sorted_by_wins
  end
end
