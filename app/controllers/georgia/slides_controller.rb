module Georgia
  class SlidesController < ApplicationController

    # Renders new portlet for revisions#edit
    def new
      @slide = Slide.new()
      @content = @slide.contents.build(locale: current_locale)
      render layout: false
    end

  end

end