class UpgradeGeorgia < ActiveRecord::Migration

  def up
    remove_column :georgia_links, :dropdown
    remove_column :georgia_links, :page_id
    remove_index :georgia_links, [:menu_id, :page_id]

    add_column :georgia_links, :ancestry, :string
    add_index :georgia_links, :ancestry
  end

  def down
    add_column :georgia_links, :dropdown, :boolean
    add_column :georgia_links, :page_id, :integer
    add_index :georgia_links, [:menu_id, :page_id]

    remove_column :georgia_links, :ancestry
    remove_index  :georgia_links, :ancestry
  end

end