# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.where(user1_id: current_user.id).or(Friendship.where(user2_id: current_user.id))
  end

  def new
    @friendships = Friendship.where(user1_id: current_user.id).or(Friendship.where(user2_id: current_user.id))
    @friendship = Friendship.new
    @user = current_user

    # Handle the search query
    if params[:query].present? && params[:query][:query].present?
      @users = User.search_by_username(params[:query][:query])
    else
      @users = [] # No search query, so we won't display any users
    end
  end

  def create
    user2 = User.find_by(id: friendship_params[:user2_id])

    if user2 == current_user
      flash[:alert] = "You cannot be friends with yourself."
      redirect_to new_user_friendship_path
      return
    end

    existing_friendship = Friendship.find_by(user1_id: current_user.id, user2_id: user2.id) ||
                          Friendship.find_by(user1_id: user2.id, user2_id: current_user.id)

    if existing_friendship
      flash[:alert] = "Friendship already exists between you and #{user2.username}."
      redirect_to home_path
    else
      @friendship = Friendship.new(friendship_params)
      @friendship.status = 'pending'
      @friendship.user1_id = current_user.id

      if @friendship.save
        redirect_to home_path, notice: "Friendship request sent."
      else
        render :new
      end
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.status = 'accepted'
    @friendship.save
    redirect_to home_path
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      redirect_to home_path, alert: 'friendship ended successfully'
    else
      # Handle friendship not found or destruction failure
      redirect_to home_path, alert: 'friendship could not be ended'
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user2_id)
  end
end
