class ProductsController < ApplicationController
  load_and_authorize_resource

  def show
    @order_item = current_order.line_items.new
  end
end
