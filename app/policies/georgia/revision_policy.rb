module Georgia
  class RevisionPolicy < Policy

    attr_reader :page, :attributes
    attr_accessor :revision

    def initialize controller, page, revision, attributes
      @page = page
      @revision = revision
      @attributes = attributes
      super
    end

    def self.update controller, page, revision, attributes
      new(controller, page, revision, attributes).update_attributes
    end

    def update_attributes
      if can? :manage, revision
        admin_update_attributes
      elsif can? :review, revision
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

  end
end