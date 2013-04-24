class AddTypeToGeorgiaPages < ActiveRecord::Migration

  def up
    remove_column :georgia_widgets, :position
    add_column :georgia_pages, :type, :string
  end

  def down
    add_column :georgia_widgets, :position, :integer
    remove_column :georgia_pages, :type
  end

end