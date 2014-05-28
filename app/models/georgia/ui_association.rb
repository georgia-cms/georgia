module Georgia
  class UiAssociation < ActiveRecord::Base

    # acts_as_list scope: :page

    belongs_to :revision, class_name: Georgia::Revision, foreign_key: :page_id
    belongs_to :widget
    belongs_to :ui_section

    scope :for_revision, -> (revision) { where(page_id: revision.id) }
    scope :ordered, -> { order(:position) }

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