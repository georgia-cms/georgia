module Georgia
  class Publisher

    attr_accessor :uuid

    delegate :published?, :draft?, to: :meta_page, allow_nil: :true

    def initialize uuid, options={}
      @uuid = uuid
      @user = options.fetch(:user, Georgia::User.new)
    end

    def publish page
      revision = change_state(meta_page, Georgia::Revision)
      meta_page = change_state(page, Georgia::MetaPage)
      meta_page.publish
    end

    def unpublish
      meta_page.unpublish
    end

    def review page
      change_state(page, Georgia::Review)
      page.review
    end

    def store page
      change_state(page, Georgia::Revision)
      page.store
    end

    def draft page
      change_state(page, Georgia::Draft)
      page.draft
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