require 'active_support/concern'

module Georgia
  module Concerns
    module Sorting
      extend ActiveSupport::Concern
      include Helpers

      included do
        def sort
          if params[:page]
            params[:page].each_with_index do |id, index|
              model.update_all({position: index+1}, {id: id})
            end
          end
          render nothing: true
        end
      end

    end
  end
end
