class AddPublicToGeorgiaPages < ActiveRecord::Migration

  def change
    add_column :georgia_pages, :public, :boolean, default: false
    add_index :georgia_pages, :public
  end

end