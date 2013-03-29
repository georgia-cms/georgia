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

    def namespaced_url_for(instance, options={})
      case namespace(options)
      when 'Georgia'
        georgia.url_for([options[:action], instance].compact)
      when 'Kennedy'
        kennedy.url_for([options[:action], instance].compact)
      when 'Admin'
        main_app.url_for([options[:action], :admin, instance].compact)
      else
        main_app.url_for([options[:action], instance].compact)
      end
    end
    helper_method :namespaced_url_for

    protected

    def namespace(options={})
      controller_class = options[:controller] || self.class.to_s
      @namespace ||= controller_class.split('::').first
    end

  end
end
