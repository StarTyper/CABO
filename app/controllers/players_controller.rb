class PlayersController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to @player
    else
      render 'new'
    end
  end

  private

  def player_params
    params.require(:player).permit(:user_id, :game_id, :player_id, :score)
  end
end
