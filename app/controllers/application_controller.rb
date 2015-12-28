class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource)
    if current_society
      society_user_path(current_society, resource)
    else
      new_society_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def after_update_path_for(resource)
    society_user_path(current_society, resource)
  end

  def current_society
    @current_society ||= current_user.society
  end

  helper_method :current_society
end
