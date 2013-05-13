module Georgia
  module PagesHelper

    # This needs improvement
    def render_partial_or_default view, controller=nil, locals
      render view, locals
    rescue ActionView::MissingTemplate
      begin
        if controller and controller.class.parent_name
          render "#{controller.class.parent_name.downcase}/#{controller.controller_name}/#{view}", locals
        else
          render_default view, locals
        end
      rescue ActionView::MissingTemplate
        render_default view, locals
      end
    end

    protected 
    def render_default view, locals
      render "georgia/pages/#{view}", locals
    end

  end
end
