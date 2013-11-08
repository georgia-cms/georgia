module Georgia
	class Message < ActiveRecord::Base

    attr_accessible :name, :email, :subject, :message, :attachment, :phone
    delegate :url, :current_path, :size, :content_type, :filename, to: :attachment

    validates :name, presence: true
    validates :email, format: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
    validates :message, presence: true

    mount_uploader :attachment, Georgia::AttachmentUploader

    # Anti Spam: check https://github.com/joshfrench/rakismet for more details
    include Rakismet::Model
    rakismet_attrs author: :name, author_email: :email, content: :message, comment_type: 'message'
    attr_accessible :user_ip, :user_agent, :referrer, :spam, :verified_at
    attr_accessor :permalink, :author_url

    scope :spam, where(spam: true)
    scope :ham, where(spam: false)

    # Search
    searchable do
      text :name
      text :email
      text :message
      text :subject
      text :phone
      string :spam do
        status
      end
      # For sorting:
      string :name
      string :email
      string :phone
      string :subject
      string :message
      time :created_at
    end

    def status
      @status ||= spam ? 'spam' : 'clean'
    end

  end
end