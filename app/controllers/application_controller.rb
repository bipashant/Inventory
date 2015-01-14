class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :authenticate_user!
  # before_action :custom_authentication
  # def custom_authentication
  #   if (user_signed_in?)
  #   p"email"
  #   p current_user.email
  #   elsif action_name.to_s=='new'
  #     skip_before_action :custom_authentication, :only => :new
  #   else
  #     p"saghjfgjskf"
  #     p action_name
  #   redirect_to new_user_session_path
  #   end
  # end
end
