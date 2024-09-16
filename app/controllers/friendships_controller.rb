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
    @user = current_user
    # Handle the search query
    if params[:query].present? && params[:query][:query].present?
      @users = User.search_by_username(params[:query][:query])
    else
      @users = [] # No search query, so we won't display any users
    end
    @friendship = Friendship.new(friendship_params)
    @friendship.status = 'pending'
    @friendship.user1_id = current_user.id
    if @friendship.save
      redirect_to new_user_friendship_path(current_user)
    else
      raise
      render :new
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user2_id)
  end
end
