module Georgia
	class Message < ActiveRecord::Base

    attr_accessible :name, :email, :subject, :message, :attachment, :phone
    delegate :url, :current_path, :size, :content_type, :filename, to: :attachment

    validates :name, presence: true
    validates :email, format: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
    validates :message, presence: true

    mount_uploader :attachment, Georgia::AttachmentUploader

    include PgSearch
    pg_search_scope :text_search, against: [:subject, :message, :name, :email, :phone],
      using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}}

    def self.search query
      query.present? ? text_search(query) : scoped
    end

    # Anti Spam: check https://github.com/joshfrench/rakismet for more details
    include Rakismet::Model
    rakismet_attrs author: :name, author_email: :email, content: :message, comment_type: 'message'
    attr_accessible :user_ip, :user_agent, :referrer, :spam, :verified_at
    attr_accessor :permalink, :author_url

  end
end