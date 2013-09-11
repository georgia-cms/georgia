class AddUuidToGeorgiaPages < ActiveRecord::Migration

  def up
    add_column  :georgia_pages, :uuid, :uuid
    add_index   :georgia_pages, :uuid
  end

  def down
    remove_column :georgia_pages, :uuid
    remove_index  :georgia_pages, :uuid
  end

end