class SocietiesController < ApplicationController

  def new
    @society = Society.new
    @society.users.build
  end

  def create
    @society = Society.new(society_params)
    if @society.save
      session[:user_id] = @society.users.first.id
      redirect_to society_user_path(@society, @society.users.first)
    else
      render 'new'
    end
  end

  private

  def society_params
    params.require(:society).permit!
  end
end
