class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @games = Game.all
    @is_uers = @user == current_user
    @filter = params[:filter]
    @sort_by = params[:sortby]
  end

  def baned
    @user = current_user
    @banned = @user.games
    @filter = params[:filter]
    @sort_by = params[:sortby]
  end

  private

  def user_params
    params.require(:user).permit(:title, :body, :photo)
  end
end
