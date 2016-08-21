class OrdersController < ApplicationController
  # before_action :load_order, only: [:show, :destroy]
  load_and_authorize_resource
  before_action :authenticate_user!

  def show
    @search_order = @order.line_items.select_product.search params[:q]
    @order_items = @search_order.result
  end

  def destroy
    if @order.update_attributes status: :cancel
      flash[:success] = t ".success"
      session.delete :order_id
    else
      flash[:danger] = t ".error"
    end
    redirect_to request.referrer
  end

  private
  def load_order
    @order = Order.find_by params[:id]
    if @order.nil?
      flash[:danger] = t "messages.error"
      redirect_to customer_index_path
    end
  end
end
