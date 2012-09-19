module Georgia
  class Status < ActiveRecord::Base

    attr_accessible :name, :label, :icon

    belongs_to :statusable, polymorphic: true

    validates :name, presence: true

    scope :published, where(name: 'Published')
    scope :draft, where(name: 'Draft')
    scope :pending_review, where(name: 'Pending Review')

  end
end