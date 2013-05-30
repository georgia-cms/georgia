module Georgia
  class Link < ActiveRecord::Base

    include Concerns::Contentable

    has_ancestry orphan_strategy: :destroy
    attr_accessible :parent_id

    attr_accessible :menu_id

    acts_as_list scope: :menu

    belongs_to :menu, class_name: Georgia::Menu

    scope :ordered, order('position ASC')

    validate do |link|
      link.contents.each do |content|
        errors.add(:base, "Must have a label") unless content.title.present?
        errors.add(:base, "URL must start with a forward slash (/) or http") unless content.text =~ Regexp.new('(^/)|(^http)')
      end
    end

    # returns only the last part of the url
    def slug
      @slug ||= text.match(/([\w-]*)$/)[0]
    end
  end
end