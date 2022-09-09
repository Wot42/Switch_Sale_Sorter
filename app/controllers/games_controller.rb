require "json"
require "open-uri"
require 'date'

class GamesController < ApplicationController
  def show
    # to be replaced
    games_all = Game.all.sort_by(&:sale_price)
    @games = []
    games_all.each do |game|
      show = true
      games.banhamers.each do |hammer|
        show = false if hammer.user == @user
      end
      @games.push(game) if show
    end

    @game = @games[5]
  end

  def update_all
    # NEEDS TESTING
    curent_games = Game.all
    curent_games.each do |entry|
      if ((entry[:sale_end] <=> Date.today) == -1)

        entry[:sale_start] = nil
        entry[:sale_end] = nil
        entry[:active_sale] = false
        entry.save

      end
    end
    curent_games = Game.all
     # WORKS FROM HERE


    url = "https://search.nintendo-europe.com/en/select?rows=99999&fq=price_has_discount_b%3Atrue%20AND%20system_type%3Anintendoswitch*&q=*&sort=sorting_title%20asc&start=0&wt=json"
    game_serialized = URI.open(url).read
    full_api = JSON.parse(game_serialized, symbolize_names: true)
    games_from_api = full_api[:response][:docs]

    games_from_api.each do |api_game|

      new_game = Game.new(api_to_model(api_game))

      present = nil

      curent_games.each do |entry|
        present = entry.id if entry.api_id == new_game.api_id
      end

      unless present == nil
        old_game = Game.find(present)
        old_game.update(api_to_model(api_game))
        old_game.save
      else
        new_game.save
      end

    end

    update_dates()
  end

  private

  def api_to_model(api_game)
    hash = {
      title: api_game[:title],
      pic: api_game[:image_url_h2x1_s],
      api_id: api_game[:nsuid_txt].first,
      tags: api_game[:game_categories_txt],
      price: api_game[:price_regular_f],
      sale_price: api_game[:price_discounted_f],
      discount_percentage: api_game[:price_discount_percentage_f],
      url: api_game[:url],
      tagline: api_game[:excerpt],
      age_rating: api_game[:age_rating_sorting_i],
      players: api_game[:players_to],
      active_sale: api_game[:price_has_discount_b]
    }
    return hash
  end


  def update_dates
    Game.all.each do |entry|
      if entry["active_sale"]
        if entry["sale_start"].nil?

          url_price = "https://api.ec.nintendo.com/v1/price?country=GB&lang=en&ids=#{entry[:api_id]}"
          price_serialized = URI.open(url_price).read
          price_api = JSON.parse(price_serialized, symbolize_names: true)

          unless price_api[:prices][0][:discount_price].nil?
            new_start = Date.parse(price_api[:prices][0][:discount_price][:start_datetime][0, 10])
            new_end = Date.parse(price_api[:prices][0][:discount_price][:end_datetime][0, 10])
            entry.update({
              sale_start: new_start,
              sale_end: new_end
            })
          end
        end
      end
    end
  end
end
