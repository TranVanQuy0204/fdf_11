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
      send_message
      session.delete :order_id
    else
      flash[:danger] = t "messages.error"
    end
    redirect_to root_path
   end

  private
  def send_message
    name = ChatWork::Me.get["name"]
    account_id = ChatWork::Me.get["account_id"]
    room_id = ChatWork::Me.get["room_id"]
    message = t("messages.order_finish")
    message_body = "[To:#{account_id}] #{name} #{message}!"
    ChatWork::Message.create room_id: room_id, body: message_body
  end
 end
