class CreateCkeditorAssets < ActiveRecord::Migration

  def change
    create_table :ckeditor_assets do |t|
      t.string  :data_file_name, :null => false
      t.string  :data_content_type
      t.integer :data_file_size

      t.integer :assetable_id
      t.string  :assetable_type, :limit => 30
      t.string  :type, :limit => 30

      # Save images dimensions
      t.integer :width
      t.integer :height

      t.integer :contents_count, :integer, default: 0

      t.timestamps
    end
    add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"
    add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  end

end