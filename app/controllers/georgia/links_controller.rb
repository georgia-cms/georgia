module Georgia
  class LinksController < ApplicationController

    load_and_authorize_resource class: Georgia::Link

    # Renders new portlet for menus#edit
    def create
      @link = Link.create
      @link.contents.build(locale: current_locale)
      render :show, layout: false
    end

  end

end