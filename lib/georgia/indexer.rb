require 'active_support/concern'

module Georgia
  module Indexer
    autoload :SolrAdapter, 'georgia/indexer/solr_adapter'
    autoload :TireAdapter, 'georgia/indexer/tire_adapter'

    def self.adapter
      @@adapter ||= adapter_lookup
    end

    # Delegates search to the adapter
    def self.search model, params
      adapter.search model, params
    end

    def self.register_extension indexer, klass
      return unless indexer == Georgia.indexer
      Adapter.load_extension(klass)
    end

    private

    def self.adapter_lookup
      @adapter_lookup ||= (case Georgia.indexer
        when :solr then SolrAdapter
        when :tire then TireAdapter
        else
          TireAdapter
        end)
    end

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