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

        def title         ; content.title        ; end
        def text          ; content.text         ; end
        def excerpt       ; content.excerpt      ; end
        def keywords      ; content.keywords     ; end
        def keyword_list  ; content.keyword_list ; end
        def image         ; content.image        ; end
      end

      module ClassMethods
      end
    end
  end
end