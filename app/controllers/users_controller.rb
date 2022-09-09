class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    games_all = Game.all
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
        games_all = Game.all.order("price ASC")
      elsif params[:sort] == "highest"
        games_all = Game.all.order("price DESC")
      elsif params[:sort] == "title ASC"
        games_all = Game.all.order("games.title ASC")
      elsif params[:sort] == "title DESC"
        games_all = Game.all.order("games.title DESC")
      elsif params[:sort] == "biggestdiscount"
        games_all = Game.all.order("discount_percentage DESC")
      elsif params[:sort] == "title DESC"
        games_all = Game.all.order("games.title DESC")
      elsif params[:sort] == "title DESC"
        games_all = Game.all.order("games.title DESC")
      else
        games_all = Game.all
      end
    else
      games_all = Game.all

    end


    @games = []
    games_all.each do |game|
      show = true
      hammers = game.BanHammers
      hammers.each do |hammer|
        show = false if hammer.user == @user
      end
      @games.push(game) if show
    end

    @is_uers = @user == current_user

  end

  def banned
    @user = current_user

    hammers = @user.BanHammers
    @games = []
    hammers.each do |hammer|
      @games.push(hammer)
    end

    # yemis code here but modified

  end

  private

  def user_params
    params.require(:user).permit(:title, :body, :photo)
  end
end
