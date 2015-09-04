class PagesController < ApplicationController
  def main
  end

  def society
    if Society.find_by(name: params[:society])
      redirect_to login_path
    else
      redirect_to new_society_path
    end
  end
end
