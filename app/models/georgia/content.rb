module Georgia
  class Content < ActiveRecord::Base

    acts_as_taggable_on :keywords
    attr_accessible :keyword_list

    attr_accessible :title, :text, :excerpt, :keywords, :locale, :image_id

    validates :title, length: {maximum: 255}

    belongs_to :contentable, polymorphic: true
    belongs_to :image, class_name: Ckeditor::Picture

  end
end