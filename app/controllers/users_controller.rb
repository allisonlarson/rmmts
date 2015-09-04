class UsersController < ApplicationController

  def show
    @current_user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to society_user_path(@user.society, @user)
    else
      render 'new'
    end
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
