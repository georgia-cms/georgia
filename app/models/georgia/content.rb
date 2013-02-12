module Georgia
  class Content < ActiveRecord::Base
    attr_accessible :title, :text, :excerpt, :keywords, :locale, :image_id

    validates :title, length: {maximum: 255}
    validates :keywords, length: {maximum: 255}
    # FIXME: Can't set to 255 when it is not used for meta tags purposes. Even then... what's the harm?
    # validates :excerpt, length: {maximum: 255}

    belongs_to :contentable, polymorphic: true, touch: true
    belongs_to :image, class_name: Ckeditor::Picture, touch: true

  end
end