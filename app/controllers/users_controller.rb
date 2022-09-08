class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    games_all = Game.all.sort_by(&:sale_price)
    @games=[]
    games_all.each do |game|
      show = true
      # if  defined?(game.ban_hamers)
       hammers = game.BanHammers
       hammers.each do |hammer|
          show = false if hammer.user == @user
        end
      # end
      @games.push(game) if show
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
