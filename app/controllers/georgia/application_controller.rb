module Georgia
  class ApplicationController < ActionController::Base

    layout 'georgia/application'
    helper 'georgia/ui'
    helper 'georgia/internationalization'
    helper 'georgia/form_actions'
    helper 'georgia/routes'

    protect_from_forgery
    
    before_filter :authenticate_admin!, except: :login
    
    def login
      render 'admins/sessions/new'
    end

    alias_method :current_user, :current_admin
    def current_ability
      @current_ability ||= Ability.new(current_admin)
    end

  end
end
