class BanHammersController < ApplicationController

  def create
    @game = Game.find(params[:id])
    hammer_id = nil

    if @game.BanHammers
      hammers = @game.BanHammers
      hammers.each do |hammer|
        hammer_id = hammer.id if hammer.user == current_user
      end
    end

    if hammer_id.nil?
      @ban_hammer = BanHammer.new( banHammer_params() )

      if @ban_hammer.save
        redirect_to user_path(current_user)
      else
        render :new, status: :unprocessable_entity
      end
    else
      @ban_hammer = BanHammer.find(hammer_id)
        if @ban_hammer.update( banHammer_params() )
          redirect_to user_path(current_user)
        else
          render :new, status: :unprocessable_entity
        end
    end
  end



  def destroy
    @ban_hammer = BanHammer.find(params[:id])
    @ban_hammer.destroy
    redirect_to banned_path(@ban_hammer.user), status: :see_other
  end

  private

  def banHammer_params
    params.require(:BanHammer).permit(:game_id, :user_id, :perma_ban, :owned, :until_date, :until_price)
  end
end
