class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if params.present?
      if params[:filter] == "action"
        games_all = Game.filtering(params[:filter])
      elsif params[:filter] == "adventure"
        games_all = Game.filtering(params[:filter])
      elsif params[:filter] == "fighting"
        games_all = Game.filtering(params[:filter])
      elsif params[:filter] == "Health & Fitness"
        games_all = Game.filtering(params[:filter])
      elsif params[:filter] == "music"
        games_all = Game.filtering(params[:filter])
      elsif params[:filter] == "party"
        games_all = Game.filtering(params[:filter])
      elsif params[:filter] == "platformer"
        games_all = Game.filtering(params[:filter])
      elsif params[:filter] == "puzzle"
        games_all = Game.filtering(params[:filter])
      elsif params[:filter] == "racing"
        games_all = Game.filtering(params[:filter])
      elsif params[:filter] == "rpg"
        games_all = Game.filtering(params[:filter])
      elsif params[:filter] == "shooter"
        games_all = Game.filtering(params[:filter])
      elsif params[:filter] == "simulation"
        games_all = Game.filtering(params[:filter])
      elsif params[:filter] == "sports"
        games_all = Game.filtering(params[:filter])
      elsif params[:filter] == "strategy"
        games_all = Game.filtering(params[:filter])
      elsif params[:sort] == "lowest"
        games_all = Game.all.order("price, ASC")
      elsif params[:sort] == "Title(A-Z)"
        games_all = Game.all.order("title, ASC")
      else
        games_all = Game.all
      end
    else
      games_all = Game.all

    end

    @games = games_all
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
