module Georgia
  class MetaPage < Georgia::Page

    belongs_to :published_by, class_name: Georgia::User

    has_many :drafts, foreign_key: :uuid, primary_key: :uuid
    has_many :revisions, foreign_key: :uuid, primary_key: :uuid
    has_many :reviews, foreign_key: :uuid, primary_key: :uuid

    validates :slug, uniqueness: {scope: :ancestry, message: 'has already been taken'}

    def store_as_draft
      Georgia::Draft.store(self)
    end

    def store_as_revision
      Georgia::Revision.store(self)
    end

  end
end