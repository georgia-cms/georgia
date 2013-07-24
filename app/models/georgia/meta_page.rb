module Georgia
  class MetaPage < Georgia::Page

    include Georgia::Concerns::Revisionable

    validates :slug, uniqueness: {scope: :ancestry, message: 'has already been taken'}

    def store_as_draft
      Georgia::Draft.store(self)
    end

    def store_as_revision
      Georgia::Revision.store(self)
    end

  end
end