module Georgia
  class UpdateRevision

    class Service
      attr_reader :current_user, :page, :attributes
      attr_accessor :revision

      def initialize current_user, page, revision, attributes={}
        @current_user = current_user
        @page = page
        @revision = revision
        @attributes = attributes
      end

      private

      def current_revision?
        @is_current_revision ||= (page.current_revision == revision)
      end

      def current_review?
        @is_current_review ||= (revision.review? and revision.revised_by?(current_user))
      end
    end

    class Admin < Service
      def call
        page.store if current_revision?
        revision.update(attributes)
      end
    end

    class Contributor < Service
      def call
        if current_revision?
          page.store
          page.approve_revision(page.revisions.last)
        end
        revision.review
        revision.update(attributes)
      end
    end

    class Guest < Service
      def call
        false #Guest should not be allowed in the first place.
      end
    end

  end
end