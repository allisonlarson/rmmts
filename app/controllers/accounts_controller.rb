class AccountsController < ApplicationController

  def create
    current_user.accounts.find_or_create_from_omniauth(env['omniauth.auth'])
    redirect_to (current_user)
  end

  def destroy
    current_user.accounts.find(params[:id]).destroy
    redirect_to (current_user)
  end
end
