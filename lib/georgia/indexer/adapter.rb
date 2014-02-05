module Georgia
  module Indexer
    module Adapter

      class << self

        def included(klass)
          load_extension(klass)
        end

        def load_extension(klass)
          extension = Extension.new(klass)
          begin
            require extension.path
            klass.send(:include, extension.name)
          rescue => ex
            raise "No extension for the #{Georgia.indexer} indexer: #{ex.message}"
          end
        end

        class Extension

          def initialize klass
            @klass = klass
          end

          def name
            name = @klass.to_s.gsub('::', '') + 'Extension'
            "#{Georgia::Indexer.adapter}::#{name}".constantize
          end

          def path
            "georgia/indexer/extensions/#{Georgia.indexer}_adapter/#{filename}"
          end

          def filename
            @klass.to_s.underscore
          end

        end
      end
    end
  end
end