class GamesController < ApplicationController
  before_action :set_game, only: %i[show destroy start play end]

  def index
    @games = Game.all
  end
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
    @player = Player.new
    @users = current_user.all_friends + [current_user]
    @players = (1..[@game.player_count, 5].min).map do |player_id|
      @game.players.find_by(player_id:) || Player.new
    end
  end

  def destroy
    @game.players.each(&:destroy)
    @game.game_cards.each(&:destroy)
    if @game.destroy
      redirect_to home_path, alert: 'game deleted successfully'
    else
      redirect_to game_path(@game), alert: 'game could not be deleted'
    end
  end

  def start
    @game.start = Time.now
    create_game_cards
    if @game.save
      redirect_to play_path(@game)
    else
      redirect_to @game, alert: 'game could not be started'
    end
  end

  def play
    @players = @game.players
  end

  def end
    @game.end = Time.now
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :player_count)
  end

  def add_cards(card_ids, count)
    count.times do
      card_ids.each do |card_id|
        @cards << GameCard.create!(game: @game, card_id:, position: 1)
      end
    end
  end

  def create_game_cards
    @cards = []
    add_cards([0, 13], 2)
    add_cards((1..12).to_a, 4)
    @cards.shuffle!
  end
end
