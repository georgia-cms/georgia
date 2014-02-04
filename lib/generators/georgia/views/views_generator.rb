module Georgia
  module Generators
    class ViewsGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def copy_pages_views
        copy_file "app/views/pages/show.html.erb"
        copy_file "app/views/pages/templates/_default.html.erb"
        copy_file "app/views/pages/templates/_one-column.html.erb"
        copy_file "app/views/pages/templates/_sidebar-left.html.erb"
        copy_file "app/views/pages/templates/_sidebar-right.html.erb"
        say("Successfully copied Georgia default templates to your application views.", :green)
      end

    end
  end
end