module Georgia
  class UiAssociationsController < ApplicationController

    load_and_authorize_resource class: Georgia::UiAssociation

    # Renders new portlet for revisions#edit
    def new
      @ui_association = UiAssociation.new(widget_id: params[:widget_id], page_id: params[:revision_id], ui_section_id: params[:ui_section_id])
      render layout: false
    end

  end

end