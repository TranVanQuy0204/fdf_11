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
  def destroy
    @order = current_order
    @order_item = @order.line_items.find params[:id]
    name = @order_item.product.name
    if @order_item.destroy!
      flash[:success] = t ".destroy_succes", value: name
      @order.save!
      redirect_to carts_path
    else
      flash[:danger] = t ".destroy_error", value: name
      redirect_to carts_path
    end
  end

  def update
    @order = current_order
    @order_item = @order.line_items.find params[:id]
    name = @order_item.product.name
    if @order_item.update_attributes! order_item_params
      flash[:success] = t ".update_succes", value: name
      @order.save!
      redirect_to carts_path
    else
      flash[:danger] = t ".update_error", value: name
      redirect_to carts_path
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
    unless @order_item.update_attributes quantity: quantity
      flash[:danger] = t ".update_error"
    end
  end

  def new_item
    @order_item = @order.line_items.new order_item_params
    @order_item.set_price
  end
end
