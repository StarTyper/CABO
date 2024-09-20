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
    @player = Player.new
    @users = current_user.all_friends
    @users << current_user

    @players = []
    @player1 = @game.players.find_by(player_id: 1) || Player.new
    @players << @player1
    @player2 = @game.players.find_by(player_id: 2) || Player.new
    @players << @player2
    if @game.player_count > 2
      @player3 = @game.players.find_by(player_id: 3) || Player.new
      @players << @player3
    end
    if @game.player_count > 3
      @player4 = @game.players.find_by(player_id: 4) || Player.new
      @players << @player4
    end
    if @game.player_count > 4
      @player5 = @game.players.find_by(player_id: 5) || Player.new
      @players << @player5
    end
  end

  def destroy
    @game = Game.find(params[:id])
    if @game.destroy
      redirect_to home_path, alert: 'game deleted successfully'
    else
      redirect_to game_path(@game), alert: 'game could not be deleted'
    end
  end

  def start
    @game = Game.find(params[:id])
    @game.start_time = Time.now
    if @game.save
      redirect_to play_game_path(@game)
    else
      redirect_to @game, alert: 'game could not be started'
    end
  end

  def play
    @game = Game.find(params[:id])
    @players = @game.players
  end

  def end
    @game = Game.find(params[:id])
    @game.end_time = Time.now
  end

  private

  def game_params
    params.require(:game).permit(:name, :player_count)
  end
end
