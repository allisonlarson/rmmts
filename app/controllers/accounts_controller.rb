class AccountsController < ApplicationController

  def create
    current_user.accounts.find_or_create_from_omniauth(env['omniauth.auth'])
    redirect_to society_user_path(current_society)
  end

  def destroy
    current_user.accounts.find(params[:id]).destroy
    redirect_to society_user_path(current_society)
  end
end
