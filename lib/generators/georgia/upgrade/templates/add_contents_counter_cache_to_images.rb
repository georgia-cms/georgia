class AddContentsCounterCacheToImages < ActiveRecord::Migration

  def up
    add_column :ckeditor_assets, :contents_count, :integer, default: 0
    Ckeditor::Picture.reset_column_information
    Ckeditor::Picture.find_each do |u|
      Ckeditor::Picture.update_counters u.id, :contents_count => u.contents.length
    end
  end

  def down
    remove_column :ckeditor_assets, :contents_count
  end

end