class GamesController < ApplicationController
  def show
    require "json"
    require "open-uri"

    url = "https://search.nintendo-europe.com/en/select?rows=99999&fq=price_has_discount_b%3Atrue%20AND%20system_type%3Anintendoswitch*&q=*&sort=sorting_title%20asc&start=0&wt=json"
    game_serialized = URI.open(url).read
    full_api = JSON.parse(game_serialized, symbolize_names: true)
    @games_from_api = full_api[:response][:docs]


  end

  def create
    curent_games = Game.all
    new_game = Game.new(game_params)
    respond_to do |format|
      format.html
      format.json
    end
    present = nil

    curent_games.each do |entry|
      present = entry.id if entry.api_id == new_game.api_id
    end

    p present

    unless present == nil
      old_game = Game.find(present)
      old_game.update(game_params)
      old_game.save
    else
      new_game.save
    end



  end

  private

  def game_params
    params.require(:game).permit(:title, :pic, :price, :sale_price, :api_id)
  end
end
