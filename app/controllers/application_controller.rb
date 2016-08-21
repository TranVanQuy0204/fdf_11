class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :create_filter
  include PublicActivity::StoreController
  hide_action :current_user
  include OrdersHelper
  include CanCan::ControllerAdditions
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end
  private
  def create_filter
    @search = Product.search(params[:q])
  end
end
