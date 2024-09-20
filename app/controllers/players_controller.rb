class PlayersController < ApplicationController
  # new action is in the games controller show action
  def create
    @game = Game.find(params[:game_id])
    @player = Player.new(user_id: params[:player][:user], game_id: params[:game_id],
                         player_id: params[:player][:player_id], score: 0)
    @player.status = 'accepted' if @player.user == @game.user
    if @player.save
      redirect_to @game, notice: 'Player was successfully added.'
    else
      redirect_to @game, notice: 'Player was not added.'
    end
  end

  def update
    @player = Player.find(params[:id])
    @game = @player.game
    @player.status = 'accepted'
    if @player.save
      redirect_to @game, notice: 'Invite was accepted.'
    else
      redirect_to @game, notice: 'Invite was not accepted.'
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @game = @player.game
    if @player.destroy
      if @game.user == current_user
        redirect_to @game, notice: 'Player was successfully removed.'
      else
        redirect_to home_path, notice: 'You have left the game.'
      end
    else
      redirect_to @game, notice: 'That did not work, try again.'
    end
  end

  private

  def player_params
    params.require(:player).permit(:user, :game_id, :player_id)
  end
end
