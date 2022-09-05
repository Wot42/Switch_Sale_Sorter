class UsersController < ApplicationController
  def show
  end

  def baned
    @user = User.find(params[:id])
    @baned = User.games
  end

  def shop
    @user = User.find(params[:id])
    @games = @user.games
  end

  def basket
    @user = User.find(params[:id])
    @games = []
    @user.games.each do |game|
      @games << shop.game
    end
  end


end
