class FilterProductsController < ApplicationController
  def index
    @search = Product.search(params[:q])
    @products = @search.result.order_by_created_at
      .page_kimanari(params[:page]).per(12)
    @order_item = current_order.line_items.new
  end
end
