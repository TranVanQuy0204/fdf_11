class AuthenticateController < ApplicationController

  def create
    user = User.from_omniauth env["omniauth.auth"]
    sign_in_and_redirect user
  end
end
