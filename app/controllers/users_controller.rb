class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @show = User.games
  end

  def baned
    @user = User.find(params[:id])
    @banned = User.games
  end

  def user_params
    params.require(:user).permit(:title, :body, :photo)
  end

end
