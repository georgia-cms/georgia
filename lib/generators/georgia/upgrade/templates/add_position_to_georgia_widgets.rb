class AddPositionToGeorgiaWidgets < ActiveRecord::Migration

  def up
    remove_column :georgia_widgets, :position
  end

  def down
    add_column :georgia_widgets, :position, :integer
  end

end