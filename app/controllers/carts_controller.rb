class CartsController < ApplicationController
  def index
    @order_items = current_order.line_items.select_product
  end
end
