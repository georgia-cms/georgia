module Georgia
  class ApplicationController < ActionController::Base

    include Pundit
    after_action :verify_authorized
    rescue_from Pundit::NotAuthorizedError do
      redirect_to new_user_session_path
    end

    layout :layout_by_resource

    protect_from_forgery with: :exception

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    def current_locale
      @current_locale ||= params.fetch(:locale, I18n.locale.to_s)
    end
    helper_method :current_locale

    private

    def layout_by_resource
      devise_controller? ? "georgia/devise" : "georgia/application"
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end

    # Overwriting the sign_out redirect path method
    def after_sign_out_path_for(resource_or_scope)
      new_user_session_path
    end

  end
end
