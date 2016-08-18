class CustomerController < ApplicationController

  def index
    @user = current_user
    @search_user = @user.orders.search params[:q]
    @orders = @search_user.result.page_kimanari(params[:page])
      .per params[:limit]
    respond_to do |format|
      format.html
      format.csv {send_data @orders.to_csv}
      format.xls
    end
  end
end
