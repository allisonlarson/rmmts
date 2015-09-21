class PagesController < ApplicationController
  def main
  end

  def society
    if Society.find_by(name: params[:society])
      redirect_to new_user_session_path
    else
      redirect_to new_user_registration_path
    end
  end
end
