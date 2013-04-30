class AddTypeToGeorgiaPages < ActiveRecord::Migration

  def up
    add_column :georgia_pages, :type, :string
  end

  def down
    remove_column :georgia_pages, :type
  end

end