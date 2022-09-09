class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    games_all = Game.all.sort_by(&:sale_price)

    # yemis code here


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
