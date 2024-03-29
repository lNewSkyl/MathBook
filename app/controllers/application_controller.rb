# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_theme
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_theme
    return unless params[:theme].present?

    theme = params[:theme].to_sym
    cookies[:theme] = theme
    redirect_to(request.referrer || home_path)
  end

  def about
    render '/about'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end
end
