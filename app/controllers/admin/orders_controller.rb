class Admin::OrdersController < AdminController
  load_and_authorize_resource

  def index
    @search = Order.search params[:q]
    @orders = @search.result.get_user.page_kimanari(params[:page])
      .per params[:limit]
    respond_to do |format|
      format.html
      format.csv {send_data @orders.to_csv}
      format.xls
    end
  end
  def show
    @search = @order.line_items.select_product.search params[:q]
    @order_items = @search.result
  end

  def update
    if @order.update_attributes! status: :success
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to request.referrer
  end

  def destroy
    if @order.update_attributes! status: :cancle
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to request.referrer
  end
end
