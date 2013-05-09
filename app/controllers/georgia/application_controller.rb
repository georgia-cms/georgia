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

    # FIXME: should pass the router instead of inferring from the instance module name
    def namespaced_url_for(instance, options={})
      case namespace(options)
      when 'Georgia'
        georgia.url_for([options[:action], instance].compact)
      when 'Kennedy'
        kennedy.url_for([options[:action], instance].compact)
      when 'Nancy'
        nancy.url_for([options[:action], instance].compact)
      when 'Admin'
        main_app.url_for([options[:action], :admin, instance].compact)
      else
        main_app.url_for([options[:action], instance].compact)
      end
    end
    helper_method :namespaced_url_for

    helper_method :model

    protected

    def model
      self.class.to_s.gsub(/Controller/,'').singularize.constantize
    rescue NameError
      self.class.to_s.gsub(/Controller/,'').gsub(/\w+::/,'').singularize.constantize
    end

    def namespace(options={})
      controller_class = options[:controller] || self.class.to_s
      @namespace ||= controller_class.split('::').first
    end

  end
end
