module Georgia
  class ApplicationController < ActionController::Base

    layout 'georgia/application'
    helper 'georgia/ui'
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

    helper_method :model

    def model
      self.class.to_s.gsub(/Controller/,'').singularize.constantize
    rescue NameError
      self.class.to_s.gsub(/Controller/,'').gsub(/\w+::/,'').singularize.constantize
    end

    protected

    def namespace(options={})
      controller_class = options[:controller] || self.class.to_s
      @namespace ||= controller_class.split('::').first
    end

  end
end
