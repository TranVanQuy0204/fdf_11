class CategoriesController < ApplicationController
  before_action :load_category, only: :show

  def show
    @products = @category.products.order_by_created_at
      .page_kimanari(params[:page]).per(12)
    @order_item = current_order.line_items.new
  end

  private
  def load_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = "messages.error_load"
      redirect_to root_path
    end
  end
end
