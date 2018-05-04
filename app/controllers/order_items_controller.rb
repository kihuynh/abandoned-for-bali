class OrderItemsController < ApplicationController

  def create
    @order = current_order
    @item = @order.order_items.new(item_params)
    @order.save
    session[:order_id] = @order.id
    redirect_to products_path
  end

  def update
    @order = current_order
    @item = @order.order_items.find(params[:id])
    @item.update_attributes(item_params)
    @order.save
  end

  def destroy
    @order = current_order
    @item = @order.order_items.find(params[:id])
    @item.destroy
    # respond_to do |format|
    #   format.html { redirect_to cart_url, notice: "Item successfully removed" }
    #   # format.json { head :no_content }
    #   format.js   { render :layout => false }
    # end
    @order.save
    flash[:notice] = "Item has been removed from cart"

  end

  private

  def item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
