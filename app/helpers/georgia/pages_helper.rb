module Georgia
  module PagesHelper

    # FIXME: This needs improvement
    # This methods allow overriding of partials
    #
    # For example to override view/georgia/pages/fields/_content.html.erb
    # in Admin::ThingsController
    # Simply create view/admin/things/fields/_content.html.erb
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
