require 'active_support/concern'

module Georgia
  module Concerns
    module Statusable
      extend ActiveSupport::Concern

      included do

        belongs_to :status, class_name: Georgia::Status

      end

      module ClassMethods
      end
    end
  end
end