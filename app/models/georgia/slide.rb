module Georgia
  class Slide < ActiveRecord::Base

    include Georgia::Concerns::Contentable
    include Georgia::Concerns::Orderable

    acts_as_list scope: :page
    attr_accessible :page_id
    belongs_to :revision, foreign_key: :page_id
    validates :page_id, presence: true

    # Returns a page if revision is a `current_revision` for a Georgia::Page
    def page
      @page ||= revision.try(:page)
    end

  end
end