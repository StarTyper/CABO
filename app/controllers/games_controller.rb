class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    if @game.save
      redirect_to @game
    else
      render 'new'
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    raise
    @player = Player.find(params[:id])
    @player.status = 'accepted'
    @player.save
    redirect_to game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:name, :player_count)
  end
end
