class CartsController < ApplicationController
  def show
    @order_items = current_order.line_items.includes(:product)
      .page_kimanari(params[:page]).per Settings.card_page
  end
end
