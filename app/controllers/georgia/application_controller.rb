module Georgia
  class ApplicationController < ActionController::Base

    layout :layout_by_resource

    helper 'georgia/ui'
    helper 'georgia/routes'
    helper 'georgia/devise'
    helper 'georgia/menus'

    protect_from_forgery

    before_filter :authenticate_user!, except: :login

    def login
      render 'users/sessions/new', layout: 'devise'
    end

    def home
    end

    def current_ability
      @current_ability ||= Ability.new(current_user)
    end

    private

    def layout_by_resource
      devise_controller? ? "georgia/devise" : "georgia/application"
    end

  end
end
