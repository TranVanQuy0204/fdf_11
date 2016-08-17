class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :create_filter
  include OrdersHelper
  include CanCan::ControllerAdditions

  private
  def create_filter
    @search = Product.search(params[:q])
  end
end
