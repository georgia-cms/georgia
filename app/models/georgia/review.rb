module Georgia
  class Review < Georgia::Page

    belongs_to :meta_page, foreign_key: :uuid, primary_key: :uuid

    class << self

      def store page
        revision = page.clone(as: Georgia::Review)
        revision.save(validate: false)
        revision
      end

    end

  end
end