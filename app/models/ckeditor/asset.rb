class Ckeditor::Asset < ActiveRecord::Base

  include Ckeditor::Orm::ActiveRecord::AssetBase
  include Georgia::Taggable

  delegate :url, :current_path, :size, :content_type, :filename, to: :data

  validates :data, presence: true
  attr_accessible :data

  paginates_per 16

  scope :latest, order('created_at DESC')

end
