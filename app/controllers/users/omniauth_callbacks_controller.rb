# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      handle_auth 'Google'
    end

    def github
      handle_auth 'GitHub'
    end

    def handle_auth(kind)
      @user = User.from_omniauth(request.env['omniauth.auth'])

      @user.persisted? ? proceed_authentication(kind) : proceed_registration
    end

    private

    def proceed_authentication(kind)
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: kind
      sign_in_and_redirect @user, event: :authentication
    end

    def proceed_registration
      session['devise.auth_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end
end
