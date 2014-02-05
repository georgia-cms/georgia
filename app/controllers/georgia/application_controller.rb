module Georgia
  class ApplicationController < ActionController::Base

    before_filter :authenticate_user!
    layout :layout_by_resource

    protect_from_forgery

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

  end
end
