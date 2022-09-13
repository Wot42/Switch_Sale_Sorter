class CookiesController < ApplicationController

  def filter
    cookies[:filter] = params[:filter]
  end

  def clear_filter
    cookies.delete(:filter)
  end

  def sort
    cookies[:sort] = params[:sort]
  end

  def clear_sort
    cookies.delete(:sort)
  end
end
