module Georgia
  class Slide < ActiveRecord::Base

    include Georgia::Concerns::Contentable

    # acts_as_list scope: :page
    belongs_to :revision, foreign_key: :page_id
    validates :page_id, presence: true

    scope :ordered, -> { order(:position) }

    # Returns a page if revision is a `current_revision` for a Georgia::Page
    def page
      @page ||= revision.try(:page)
    end

  end
end