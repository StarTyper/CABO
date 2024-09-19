class PlayersController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @player = Player.new( user_id: params[:player][:user], game_id: params[:game_id],
                          player_id: params[:player][:player_id], score: 0)
    @player.status = 'accepted' if @player.user == @game.user
    if @player.save
      redirect_to @game, notice: 'Player was successfully added.'
    else
      redirect_to @game, notice: 'Player was not added.'
    end
  end

  private

  def player_params
    params.require(:player).permit(:user, :game_id, :player_id)
  end
end
