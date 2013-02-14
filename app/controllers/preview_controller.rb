class PreviewController < PagesController

  load_and_authorize_resource class: Georgia::Page

  def page
    @page = Georgia::Page.find(params[:id]).decorate
    render template: 'pages/show', layout: 'layouts/application'
  end

end