module Georgia
  class ApplicationController < ActionController::Base

    layout 'georgia/application'
    helper 'georgia/ui'
    helper 'georgia/internationalization'
    helper 'georgia/form_actions'
    helper 'georgia/routes'
    helper 'georgia/devise'
    helper 'georgia/menus'

    protect_from_forgery

    before_filter :authenticate_user!, except: :login

    def login
      render 'users/sessions/new'
    end

    def home
    end

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

  end
end
