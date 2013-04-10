module Georgia
  class UiAssociation < ActiveRecord::Base

    include Georgia::Orderable
    acts_as_list scope: :page

    belongs_to :page, touch: true
    belongs_to :widget, touch: true
    belongs_to :ui_section, touch: true
    attr_accessible :position, :widget_id, :ui_section_id, :page_id

    validate :associations

    protected

    # Validations
    def associations
      errors.add(:base, "An association to a page is required.") unless page_id.present?
      errors.add(:base, "An association to a UI Section is required.") unless ui_section_id.present?
      errors.add(:base, "An association to a Widget is required.") unless widget_id.present?
    end

  end
end