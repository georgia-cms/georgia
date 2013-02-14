module Georgia
  class Slide < ActiveRecord::Base

    include Georgia::Contentable

    acts_as_list scope: :page

    attr_accessible :position, :page_id

    belongs_to :page

    # image is a belongs_to on content
    # Accessable via decorator at the moment

    delegate :title, :text, :excerpt, :keywords, :published_by, :published_at, to: :contents

    scope :ordered, order(:position)

  end
end