module OrdersHelper

  def current_order
    user_signed_in? ? user_signed : Order.new
  end
  private
  def user_signed
    if session[:order_id].present?
      current_user.orders.find(session[:order_id])
    else
      current_user.orders.new
    end
  end
end
