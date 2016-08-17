class PagesController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all.take Settings.product_take
    @order_item = current_order.line_items.new
  end
end
