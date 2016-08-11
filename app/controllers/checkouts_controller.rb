class CheckoutsController < ApplicationController
  def index
    @order_items = current_order.line_items.joins(:product).
      select "line_items.*, products.name as product_name,
      products.image as image"
  end
end
