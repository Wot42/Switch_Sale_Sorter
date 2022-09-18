require "json"
require "open-uri"
require 'date'
require "nokogiri"

class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  def show
    @game = Game.find(params[:id])
    @user = current_user
    html_file = URI.open("https://www.nintendo.co.uk#{@game.url}").read
    html_doc = Nokogiri::HTML(html_file)
    @description = []
    @pics = []
    html_doc.search(".game-section-content .content p").each do |element1|
      @description.push(element1.text.strip)
    end


    html_doc.search(".page-img img").each do |element1|
      unless  element1.attribute(":alt") || element1.attribute("v-bind:alt")
        pic_url = element1.attribute("data-xs").value.gsub("_TM_Standard", "")


        @pics.push(pic_url)
      end
    end
    @user = current_user


  end

  def update_all
    hammers_list = BanHammer.all.select { |hammer_find| hammer_find[:until_date] }
    hammers_list.each do |entry|
      if ((entry[:until_date] <=> Date.today) == -1)
        ban_it = true
        ban_it = false if entry[:perma_ban] && entry[:perma_ban] == true
        ban_it = false if entry[:owned] && entry[:owned] == true
        ban_it = false if entry[:until_price]

        entry.destroy if ban_it == true
      end
    end

    curent_games = Game.all.select { |game_find| game_find[:active_sale] == true }
    curent_games.each do |entry|
      if ((entry[:sale_end] <=> Date.today) == -1)

        if entry.BanHammers[0]
          entry[:sale_start] = nil
          entry[:sale_end] = nil
          entry[:active_sale] = false
          entry.save
        else
          entry.destroy
        end
      end
    end
    curent_games = Game.all



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

    update_dates_new()

    cookies[:last_updated] = Date.today
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


  def update_dates()
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

  def update_dates_new()
    dates_array = []
    games_all = Game.all.select { |game_find| game_find[:active_sale] == true }
    games_all.each do |entry|
        if entry["sale_start"].nil?
          dates_array.push(entry)
          if dates_array.size == 50
            process_date(dates_array)
            dates_array = []
          end
        end
    end
    process_date(dates_array)
  end

  def process_date(dates_array)
    if dates_array[0]
      url_price = "https://api.ec.nintendo.com/v1/price?country=GB&lang=en&ids=#{dates_array[0][:api_id]}"
      dates_array.last((dates_array.size - 1)).each do |new_id|
        url_price += "%2C#{new_id[:api_id]}"
      end
      price_serialized = URI.open(url_price).read
      price_api = JSON.parse(price_serialized, symbolize_names: true)

      dates_array.each_with_index do | new_price, index |

        unless price_api[:prices][index][:discount_price].nil?
          new_start = Date.parse(price_api[:prices][index][:discount_price][:start_datetime][0, 10])
          new_end = Date.parse(price_api[:prices][index][:discount_price][:end_datetime][0, 10])
          new_price.update({
            sale_start: new_start,
            sale_end: new_end
          })
        end
      end
    end
  end
end
