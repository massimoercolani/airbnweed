class ItemsController < ApplicationController
  def create
    @item = Item.new(item_params)
    @item.in_stock = true
    @item.user = current_user
    if @item.save
      redirect_to user_path(current_user)
    else
      alert = @item.errors.messages.first.flatten.join(": ")
      redirect_to(:back, alert: alert)
    end
  end

  def out_of_stock
    @item = Item.find(params[:id])
    @item.update(in_stock: false)
    redirect_to(:back)
  end

  def back_in_stock
    @item = Item.find(params[:id])
    @item.update(in_stock: true)
    redirect_to(:back)
  end

  private

  def item_params
    params.require(:item).permit(:name, :price)
  end
end
