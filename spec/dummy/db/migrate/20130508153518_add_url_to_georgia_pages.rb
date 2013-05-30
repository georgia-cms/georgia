class AddUrlToGeorgiaPages < ActiveRecord::Migration

  def up
    add_column :georgia_pages, :url, :string
  end

  def down
    remove_column :georgia_pages, :url
  end

end