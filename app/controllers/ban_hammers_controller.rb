class BanHammersController < ApplicationController

  def create
    @ban_hammer = BanHammer.new(ban_hammer_params)
    @ban_hammer.user = current_user

    if @ban_hammer.save
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @ban_hammer = BanHammer.find(params[:id])
    if @ban_hammer.update(BanHammer_params)
      redirect_to BanHammer_path(@ban_hammer)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @ban_hammer = BanHammer.find(params[:id])
    @ban_hammer.destroy
    redirect_to baned_path(@ban_hammer.user), status: :see_other
  end

  private

  def BanHammer_params
    params.require(:BanHammer).permit(:game_id)
  end
end
