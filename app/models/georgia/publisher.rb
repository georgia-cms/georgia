module Georgia
  class Publisher

    attr_accessor :uuid, :meta_klass, :user

    delegate :published?, :draft?, to: :meta_page, allow_nil: :true

    def initialize uuid, options={}
      @uuid = uuid
      @meta_klass = options.fetch(:class, inferred_class)
      @user = options.fetch(:user, Georgia::User.new)
    end

    def publish
      meta_page.publish
    end

    def unpublish
      meta_page.unpublish
    end

    def approve review
      review.publish
      change_state(meta_page, Georgia::Revision)
      change_state(review, meta_klass)
    end

    def review draft
      draft.review
      change_state(draft, Georgia::Review)
    end

    def store page
      page.store
      change_state(page, Georgia::Revision)
    end

    def create_draft
      draft = meta_page.clone_as(Georgia::Draft)
      draft.created_by = user
      draft.draft
      draft.save
      draft
    end

    # Associations

    def pages
      Georgia::Page.where(uuid: uuid)
    end

    def meta_page
      meta_klass.where(uuid: uuid).limit(1).first
    end

    def reviews
      Georgia::Review.where(uuid: uuid)
    end

    def revisions
      Georgia::Revision.where(uuid: uuid)
    end

    def drafts
      Georgia::Draft.where(uuid: uuid)
    end

    protected

    def change_state page, model
      page.update_attribute(:type, model.to_s)
      page.becomes(model)
    end

    def inferred_class
      (pages.map(&:type) - ['Georgia::Draft', 'Georgia::Review', 'Georgia::Revision']).first.constantize
    end

  end
end