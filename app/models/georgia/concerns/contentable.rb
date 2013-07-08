require 'active_support/concern'

module Georgia
  module Concerns
    module Contentable
      extend ActiveSupport::Concern

      included do
        has_many :contents, as: :contentable, dependent: :destroy, class_name: Georgia::Content
        accepts_nested_attributes_for :contents
        attr_accessible :contents_attributes

        def content
          @content ||= contents.select{|c| c.locale == I18n.locale.to_s}.first || Georgia::Content.new
        end

				delegate :title, :text, :excerpt, :keywords, :keyword_list, :image, to: :content
      end

      module ClassMethods
      end
    end
  end
end