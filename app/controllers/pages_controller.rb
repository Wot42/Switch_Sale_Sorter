class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @games = Game.all
    # sort

    # filter
    @users = User.all
    @user = current_user
    @filter = params[:filter]
    @sort_by = params[:sortby]
  end
end
