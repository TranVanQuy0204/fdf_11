class LineItemsController < ApplicationController

  def create
    @order = current_order
    get_order_item
    if @order.save!
      session[:order_id] = @order.id
      flash[:success] = t ".create_succes"
      redirect_to carts_path
    else
      flash[:danger] = t ".update_error"
      redirect_to root_path
    end
  end

  private
  def order_item_params
    params.require(:line_item).permit :quantity, :product_id
  end

  def get_order_item
    @order_item = @order.line_items
      .find_by product_id: params[:line_item][:product_id]
    @order_item = @order_item.nil? ? new_item : update_item
  end

  def update_item
    quantity = params[:line_item][:quantity].to_i + @order_item.quantity
    @order_item.update_attributes! quantity: quantity
  end

  def new_item
    @order_item = @order.line_items.new order_item_params
    @order_item.set_price
  end
end
