module Georgia
  class Slide < ActiveRecord::Base

    include Georgia::Contentable

    acts_as_list scope: :page

    attr_accessible :position, :page_id

    belongs_to :page


    delegate :title, :text, :excerpt, :keywords, :published_by, :published_at, :image, to: :contents, allow_nil: true

    scope :ordered, order(:position)

    validate :page_association

    protected

    # Validations
    def page_association
      errors.add(:base, "An association to a page is required.") unless page_id.present?
    end

  end
end