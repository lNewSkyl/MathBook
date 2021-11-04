class ApplicationController < ActionController::Base
  def about
    render "/about"
  end

  before_action :configure_permitted_parameters,
    if: :devise_controller?

      protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
        devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
      end
end

