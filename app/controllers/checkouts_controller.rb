 class CheckoutsController < ApplicationController
   def index
    if current_order.id.present?
      @order_items = current_order.line_items.select_product
    else
      flash[:danger] = t "messages.none_product"
      redirect_to root_path
    end
  end

  def update
    if current_order.update_attributes status: :pendding
      flash[:success] = t "messages.success"
      session.delete :order_id
    else
      flash[:danger] = t "messages.error"
    end
    redirect_to root_path
   end
 end
