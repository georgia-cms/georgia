module Georgia
  module RoutesHelper

    def georgia_url
      'http://www.georgiaonrails.com'
    end

    def motioneleven_url
      'http://www.motioneleven.com'
    end

    def namespaced_url_for(instance, action=nil)
      case namespace
      when 'Georgia'
        georgia.url_for([action, instance].compact)
      when 'Kennedy'
        kennedy.url_for([action, instance].compact)
      when 'Admin'
        main_app.url_for([action, :admin, instance].compact)
      else
        main_app.url_for([action, instance].compact)
      end
    end

    def georgia?
      namespace == 'Georgia'
    end

    def kennedy?
      namespace == 'Kennedy'
    end

    def main_app?
      namespace == 'Admin'
    end

    protected

    def namespace
      @namespace ||= controller.class.to_s.split('::').first
    end

  end
end