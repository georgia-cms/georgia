class Ckeditor::Asset < ActiveRecord::Base
  include Ckeditor::Orm::ActiveRecord::AssetBase

  delegate :url, :current_path, :size, :content_type, :filename, to: :data

  validates :data, presence: true
  validates :url, uniqueness: true

  acts_as_taggable_on :tags
  attr_accessible :tag_list, :description, :data

  paginates_per 16

  scope :latest, order('created_at DESC')

end
