module Georgia
  class Revision < ActiveRecord::Base

    self.table_name = :georgia_pages

    belongs_to :page, foreign_key: :uuid, primary_key: :uuid

    class << self

      def store page
        revision = page.clone(as: Georgia::Revision)
        revision.save!
        revision
      end

    end

  end
end