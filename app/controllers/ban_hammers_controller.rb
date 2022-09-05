class BanHammersController < ApplicationController

  def create
    @BanHammer = BanHammer.new(ban_hammer_params)
    @BanHammer.user = current_user

    if @BanHammer.save
      redirect_to shop_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @BanHammer = BanHammer.find(params[:id])
    if @BanHammer.update(BanHammer_params)
      redirect_to BanHammer_path(@BanHammer)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @BanHammer = BanHammer.find(params[:id])
    @BanHammer.destroy
    redirect_to shop_path(@BanHammer.user), status: :see_other
  end

  private

  def BanHammer_params
    params.require(:BanHammer).permit(:game_id)
  end
end
