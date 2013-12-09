module Georgia
  class Slide < ActiveRecord::Base

    include Georgia::Concerns::Contentable
    include Georgia::Concerns::Orderable

    acts_as_list scope: :page
    attr_accessible :page_id
    belongs_to :revision, foreign_key: :page_id
    validates :page_id, presence: true

  end
end