class AddressesController < ApplicationController
  before_action :authenticate_user!

  def update
    address = params[:address]
    address = address.blank? ? current_user.address : address
    result = current_order.update_attributes ship_address: address
    respond_to do |format|
      format.js {render json: {result: result, value: address}}
    end
  end
end
