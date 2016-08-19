class UsersController < ApplicationController
  load_and_authorize_resource

  def update
    if @user.update_attributes user_params
      flash[:success] = t "messages.update_success"
      redirect_to request.referrer
    else
      render :new
    end
  end

  def edit
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :address,
      :phone
  end
end
