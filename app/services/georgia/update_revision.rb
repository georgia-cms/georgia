module Georgia
  class UpdateRevision

    attr_reader :controller, :page, :attributes
    attr_accessor :revision


    def initialize controller, page, revision, attributes
      @controller = controller
      @page = page
      @revision = revision
      @attributes = attributes
    end

    def call
      if can? :review, revision
        contributor_update_attributes
      else
        false
      end
    end

    private

    def admin_update_attributes
      page.store if current_revision?
      revision.update_attributes(attributes)
    end

    def contributor_update_attributes
      if current_revision?
        page.store
        page.approve_revision(page.revisions.last)
      end
      revision.review
      revision.update_attributes(attributes)
    end

    def current_revision?
      @is_current_revision ||= (page.current_revision == revision)
    end

    def current_review?
      @is_current_review ||= (revision.review? and revision.revised_by?(current_user))
    end

    private

    def method_missing(*args, &block)
      controller.send(*args, &block)
    end

  end
end