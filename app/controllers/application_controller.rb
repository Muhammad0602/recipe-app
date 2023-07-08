class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  before_action :authenticate_user!
  before_action :set_current_user

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :surname, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :surname, :email, :password, :current_password)
    end
  end

  def set_current_user
    @current_user = current_user
  end
end
