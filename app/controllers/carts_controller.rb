class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    @order_items = current_order.line_items.select_product
  end
end
