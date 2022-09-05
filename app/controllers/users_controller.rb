class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @show = User.games
  end

  def baned
    @user = User.find(params[:id])
    @baned = User.games
  end

end
