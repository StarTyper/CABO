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
    @users = current_user.all_friends + [current_user]

    @players = (1..[@game.player_count, 5].min).map do |player_id|
      @game.players.find_by(player_id: player_id) || Player.new
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
    create_game_cards
    if @game.save
      redirect_to play_path(@game)
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

  def create_game_cards
    @cards = []
    add_cards([1, 13], 2)
    add_cards((2..12).to_a, 4)
    @cards.shuffle!
  end

  def add_cards(card_ids, count)
    count.times do
      card_ids.each do |card_id|
        @cards << GameCard.create!(game_id: @game.id, card_id:, position: 0)
      end
    end
  end
end
