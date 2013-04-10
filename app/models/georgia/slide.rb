module Georgia
  class Slide < ActiveRecord::Base

    include Georgia::Contentable
    include Georgia::Orderable

    acts_as_list scope: :page
    attr_accessible :page_id

    belongs_to :page

    validate :page_association

    protected

    # Validations
    def page_association
      errors.add(:base, "An association to a page is required.") unless page_id.present?
    end

  end
end