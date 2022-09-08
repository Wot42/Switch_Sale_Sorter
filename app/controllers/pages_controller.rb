class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @game = Game.all
    @users = User.all
    @user = current_user
    @filter = params[:filter]
    @sort_by = params[:sortby]
  end
end
