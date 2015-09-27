class SocietiesController < ApplicationController

  def new
    @society = Society.new
  end

  def create
    @society = Society.new(society_params)
    users = society_params.delete(:invitees)
    if @society.save
      @society.invite(users, current_user) if users
      current_user.update_attributes!(society: @society)
      redirect_to society_user_path(@society)
    else
      render 'new'
    end
  end

  private

  def society_params
    params.require(:society).permit!
  end
end
