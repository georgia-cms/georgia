module Georgia
  module RoutesHelper

    def georgia_url
      'http://www.georgiaonrails.com'
    end

    def motioneleven_url
      'http://www.motioneleven.com'
    end

    def namespaced_url_for(model, action=nil)
      case namespace
      when 'Georgia'
        georgia.url_for([action, model].compact)
      when 'Admin'
        main_app.url_for([action, :admin, model].compact)
      else
        main_app.url_for([action, model].compact)
      end
    end

    protected

    def namespace
      @namespace ||= controller.class.to_s.split('::').first
    end

  end
end