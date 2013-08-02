module Georgia
  module Paths

    # Should be in a helper
    def app_path
      File.expand_path('../../app', called_from)
    end

    def decorator_path name
      File.expand_path("decorators/georgia/#{name}_decorator.rb", app_path)
    end

    %w{controller helper mailer model}.each do |resource|
      class_eval <<-RUBY
      def #{resource}_path(name)
        File.expand_path("#{resource.pluralize}/georgia/\#{name}.rb", app_path)
      end
      RUBY
    end

  end
end