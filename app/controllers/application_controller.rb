class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :authenticate_user!
  def custom_authentication
    if (user_signed_in?)

    else
      raise AccessDenied
    end
  end

  class AccessDenied < StandardError; end

  rescue_from AccessDenied, with: :access_denied

  def access_denied
    redirect_to new_user_session_path, alert:'Nope, can’t allow to do that.'
  end
end
