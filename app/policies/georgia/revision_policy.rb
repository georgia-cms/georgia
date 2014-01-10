module Georgia
  class RevisionPolicy

    attr_reader :page, :revision, :attributes

    def initialize page, revision, attributes
      @page, @revision, @attributes = page, revision, attributes
    end

    def self.update page, revision, attributes
      new(page, revision, attributes).update_attributes
    end

    def update_attributes
      page.store if page.current_revision == revision
      revision.update_attributes(attributes)
    end

  end
end