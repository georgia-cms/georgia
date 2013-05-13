module Georgia
  module PagesHelper
    def render_partial_or_default view, locals
      render view, locals
    rescue ActionView::MissingTemplate
      render "georgia/pages/#{view}", locals
    end
  end
end
