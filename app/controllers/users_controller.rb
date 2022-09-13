class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show


  def show
    @user = User.find(params[:id])
    games_all = Game.activesale(true)
    games_all = games_all.filtering(cookies[:filter]) if cookies[:filter]

    if cookies[:sort]
      if cookies[:sort] == "highest"
        games_all = games_all.sort_by{|k| k[:sale_price]}.reverse
      elsif cookies[:sort] == "title ASC"
        games_all = games_all.sort_by{|k| k[:title]}
      elsif cookies[:sort] == "title DESC"
        games_all = games_all.sort_by{|k| k[:title]}.reverse
      elsif cookies[:sort] == "lowest"
        games_all = games_all.sort_by{|k| k[:sale_price]}
      elsif cookies[:sort] == "biggestdiscount"
        games_all = games_all.sort_by{|k| k[:discount_percentage]}.reverse
      elsif cookies[:sort] == "sale_start"
        games_all = games_all.sort_by{|k| k[:sale_start]}
      elsif cookies[:sort] == "sale_end"
        games_all = games_all.sort_by{|k| k[:sale_end]}
      end
    end
    @games = []
    games_all.each do |game|
      show = true
      hammers = game.BanHammers
      hammers.each do |hammer|
        if hammer.perma_ban
          show = false if hammer.user == @user && hammer.perma_ban
        end
        if hammer.owned
          show = false if hammer.user == @user && hammer.owned && @user == current_user
        end
        if hammer.until_date
          show = false if hammer.user == @user && ((hammer.until_date <=> Date.today) == - 1)
        end
        if hammer.until_price
          show = false if hammer.user == @user && hammer.until_price > game.sale_price
        end

      end
      @games.push(game) if show
    end

    @is_users = @user == current_user

  end

  def banned
    @user = current_user

    hammers = @user.BanHammers
    games_all = []
    hammers.each do |hammer|
      games_all.push(hammer.game)
    end

    games_all = games_all.select{|game_find| game_find[:tags].include? cookies[:filter] } if cookies[:filter]

    if cookies[:sort]
      if cookies[:sort] == "highest"
        games_all = games_all.sort_by{|k| k[:price]}.reverse
      elsif cookies[:sort] == "title ASC"
        games_all = games_all.sort_by{|k| k[:title]}
      elsif cookies[:sort] == "title DESC"
        games_all = games_all.sort_by{|k| k[:title]}.reverse
      elsif cookies[:sort] == "lowest"
        games_all = games_all.sort_by{|k| k[:price]}
      end
    end

    @games = games_all

  end

  private

  def user_params
    params.require(:user).permit(:title, :body, :photo)
  end
end
