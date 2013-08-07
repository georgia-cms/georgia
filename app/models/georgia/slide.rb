module Georgia
  class Slide < ActiveRecord::Base

    include Georgia::Concerns::Contentable
    include Georgia::Concerns::Orderable

    acts_as_list scope: :page
    attr_accessible :page_id

    belongs_to :page, class_name: Georgia::Revision

    validate :page_association

    protected

    # Validations
    def page_association
      errors.add(:base, "An association to a page is required.") unless page_id.present?
    end

  end
end