class UsersController < ApplicationController

  def show
    @current_user = current_user
  end

  def edit
    @current_user = current_user
  end

  def destroy
    current_user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
