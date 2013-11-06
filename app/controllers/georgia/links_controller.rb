module Georgia
  class LinksController < ApplicationController

    load_and_authorize_resource class: Georgia::Link

    # Renders new portlet for menus#edit
    def new
      @link = Link.new()
      @link.contents.build(locale: current_locale)
      render layout: false
    end

  end

end