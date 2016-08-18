class Admin::PagesController < AdminController
  def index
    @orders = Order.all.group_by_date
  end
end
