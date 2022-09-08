class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @games = Game.all
    if params.present?
      if params[:filter] == "action"
        @games = Game.filtering(params[:filter])
      elsif params[:filter] == "adventure"
        # params[:filter] == "Fighting"
        # params[:filter] == "Health & Fitness"
        # params[:filter] == "Music"
        # params[:filter] == "Party"
        # params[:filter] == "Platformer"
        # params[:filter] == "Puzzle"
        # params[:filter] == "Racing"
        # params[:filter] == "RPG"
        # params[:filter] == "Shooter"
        # params[:filter] == "Simulation"
        # params[:filter] == "Sports"
        # params[:filter] == "Strategy"
      end

    else
      @games = Game.all

    end

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
