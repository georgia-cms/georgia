module Georgia
  class PublishedPage < Georgia::Page

    belongs_to :page, foreign_key: :uuid, primary_key: :uuid

  end
end