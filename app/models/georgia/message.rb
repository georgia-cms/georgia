module Georgia
	class Message < ActiveRecord::Base

		attr_accessible :name, :email, :subject, :message, :attachment

		validates :name, presence: true
		validates :email, presence: true, format: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
		validates :message, presence: true

    mount_uploader :attachment, CkeditorAttachmentFileUploader, :mount_on => :data_file_name

    include PgSearch
    pg_search_scope :text_search, against: [:subject, :message, :name, :email], using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}}

    def self.search query
      query.present? ? text_search(query) : scoped
    end

	end
end