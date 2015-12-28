class AccountsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.accounts.find_or_create_from_omniauth(env['omniauth.auth'])
    current_user.update_attributes!(image: env['omniauth.auth']['extra']['raw_info']['profile_picture_url'])
    redirect_to society_user_path(current_society, current_user)
  end

  def destroy
    current_user.accounts.find(params[:id]).destroy
    redirect_to society_user_path(current_society, current_user)
  end
end
