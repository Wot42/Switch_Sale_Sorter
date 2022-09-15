class CookiesController < ApplicationController
  skip_before_action :authenticate_user!

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
