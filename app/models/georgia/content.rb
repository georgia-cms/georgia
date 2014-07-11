module Georgia
  class Content < ActiveRecord::Base

    acts_as_taggable_on :keywords

    validates :title, length: {maximum: 255}
    validates :locale, presence: true

    belongs_to :contentable, polymorphic: true
    belongs_to :image, class_name: Ckeditor::Picture

  end
end