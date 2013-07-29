module Georgia
  class Publisher

    attr_accessor :uuid, :user

    delegate :published?, :draft?, to: :meta_page, allow_nil: :true

    def initialize uuid, options={}
      @uuid = uuid
      @user = options.fetch(:user, Georgia::User.new)
    end

    def publish page
      page.publish
      change_state(meta_page, Georgia::Revision)
      change_state(page, Georgia::MetaPage)
    end

    def approve review
      review.publish
      change_state(meta_page, Georgia::Revision)
      change_state(review, Georgia::MetaPage)
    end

    def unpublish
      meta_page.unpublish
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
      Georgia::MetaPage.where(uuid: uuid).limit(1).first
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

  end
end