module Georgia
  module RoutesHelper

    def georgia_url
      'http://www.georgiaonrails.com'
    end

    def motioneleven_url
      'http://www.motioneleven.com'
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

  end
end