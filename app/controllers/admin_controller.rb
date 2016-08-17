class AdminController < ApplicationController
  layout "admin"
  before_action :authenticate_user!, :verify_admin

  private
  def verify_admin
    unless current_user.admin?
      flash[:danger] = t "messages.admin_login"
      redirect_to root_path
    end
  end
end
