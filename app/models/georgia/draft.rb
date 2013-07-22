module Georgia
  class Draft < Georgia::Page

    belongs_to :meta_page, foreign_key: :uuid, primary_key: :uuid

    def ask_for_review
      self.becomes Georgia::Review
    end
    alias_method :wait_for_review, :ask_for_review

    class << self

      def store page
        revision = page.clone(as: Georgia::Draft)
        revision.save(validate: false)
        revision
      end

    end

  end
end