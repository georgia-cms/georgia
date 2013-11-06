module Georgia
  class Link < ActiveRecord::Base

    include Concerns::Contentable

    has_ancestry orphan_strategy: :adopt
    attr_accessible :parent_id

    attr_accessible :menu_id

    acts_as_list scope: :menu

    belongs_to :menu, class_name: Georgia::Menu, touch: true

    scope :ordered, order('position ASC')

    before_validation :ensure_forward_slash, on: :create

    def ensure_forward_slash
      self.contents.each do |content|
        content.text.insert(0, '/') unless content.text =~ Regexp.new('(^/)|(^http)')
      end
    end

    # returns only the last part of the url
    def slug
      @slug ||= text.match(/([\w-]*)$/)[0]
    end
  end
end