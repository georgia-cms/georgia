module Georgia
  class Content < ActiveRecord::Base
    attr_accessible :published_at, :title, :text, :excerpt, :keywords, :locale, :image_id

    validates :title, length: {maximum: 255}
    validates :keywords, length: {maximum: 255}
    validates :excerpt, length: {maximum: 255}

    belongs_to :contentable, polymorphic: true

    belongs_to :image, class_name: Ckeditor::Picture

  end
end