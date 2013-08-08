require 'active_support/concern'

module Georgia
  module Concerns
    module Notifying
      extend ActiveSupport::Concern
      include Helpers

      included do

        private

        def notify(message)
          Notifier.notify_editors(message, url_for([:edit, @page, @revision])).deliver
        end

      end
    end
  end
end