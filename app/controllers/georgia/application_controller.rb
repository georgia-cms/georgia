module Georgia
  class ApplicationController < ActionController::Base

    # Required otherwise get the error 'uninitialized Ability'
    # require 'devise'

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

    def current_ability
      @current_ability = Georgia::Ability.new(current_admin)
    end
    
  end
end
