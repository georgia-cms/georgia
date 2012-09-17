module Georgia
	class Slide < ActiveRecord::Base

		acts_as_list scope: :page

		attr_accessible :position, :page_id

		belongs_to :page

		delegate :title, :text, :excerpt, :keywords, :published_by, :published_at, to: :contents

		has_many :contents, as: :contentable, dependent: :destroy
		accepts_nested_attributes_for :contents
		attr_accessible :contents_attributes

	end
end