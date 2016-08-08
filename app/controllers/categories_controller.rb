class CategoriesController < ApplicationController
  before_action :load_category, only: [:show]

  def show
    @products = @category.products.sort.paginate page: params[:page],
      per_page: Settings.per_page_product
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
