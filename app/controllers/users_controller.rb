class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    games_all = Game.all
    if params.present?

      if params[:filter]
        games_all = Game.filtering(params[:filter])
        if params[:sort]
          if params[:sort] == "highest"
            games_all = Game.order("price DESC").and(Game.where("'#{params[:filter]}' = ANY (tags)"))
          elsif params[:sort] == "title ASC"
            games_all = Game.order("games.title ASC").and(Game.where("'#{params[:filter]}' = ANY (tags)"))
          elsif params[:sort] == "title DESC"
            games_all = Game.order("games.title DESC").and(Game.where("'#{params[:filter]}' = ANY (tags)"))
          elsif params[:sort] == "lowest"
            games_all = Game.order("price ASC").and(Game.where("'#{params[:filter]}' = ANY (tags)"))
          elsif params[:sort] == "biggestdiscount"
            games_all = Game.order("discount_percentage DESC").and(Game.where("'#{params[:filter]}' = ANY (tags)"))
          elsif params[:sort] == "sale_start"
            games_all = Game.order("sale_start DESC").and(Game.where("'#{params[:filter]}' = ANY (tags)"))
          end
        end
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
