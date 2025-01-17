class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success, :notice
  helper_method :current_user
  helper_method :current_admin

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end
  
  private

  def error_message(errors)
    errors.full_messages.join(", ")
  end
end
