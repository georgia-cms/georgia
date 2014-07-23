module Georgia
  class UpdateRevision

    class Service
      attr_reader :revision

      def initialize current_user, page, revision, attributes={}
        @current_user = current_user
        @page = page
        @revision = revision
        @attributes = attributes
      end

      private

      def current_revision?
        @is_current_revision ||= (@page.current_revision == @revision)
      end

      def current_review?
        false
        # @is_current_review ||= (@revision.review? and @revision.revised_by?(@current_user))
      end
    end

    class Admin < Service
      def call
        @revision.update(@attributes)
      end
    end

    class Editor < Admin
    end

    class Contributor < Service
      def call
        if current_revision?
          raise Pundit::NotAuthorizedError, 'You must be at least an Editor to update a published revision.'
        else
          @revision.update(@attributes)
        end
      end
    end

    class Guest < Service
      def call
        raise Pundit::NotAuthorizedError, 'You must be at least a Contributor to update a page.'
      end
    end

  end
end