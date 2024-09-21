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
    User.joins(:players).where(players: { game_id: @game.id }).each do |user|
      @users.delete(user)
    end
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
    assign_cards_to_positions(@game.player_count)
    redirect_path = @game.save ? play_path(@game) : @game
    alert_message = @game.save ? 'game started successfully' : 'game could not be started'
    redirect_to redirect_path, alert: alert_message
  end

  def play
    @cards = @game.game_cards
    @me = Player.find_by(user: current_user)
    @players = @game.players
    @players.each do |player|
      instance_variable_set("@player#{player.player_id}", player) if player != @me
    end
    raise
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
        @cards << GameCard.create!(game: @game, card_id:, position: 6)
      end
    end
  end

  def create_game_cards
    @cards = []
    add_cards([1, 14], 2)
    add_cards((2..13).to_a, 4)
    @cards.shuffle!
  end

  def assign_cards_to_positions(player_count)
    max_players = [player_count, 5].min
    (1..max_players).each do |position|
      @cards.drop((position - 1) * 4).first(4).each { |card| card.update(position: position) }
    end
  end
end
