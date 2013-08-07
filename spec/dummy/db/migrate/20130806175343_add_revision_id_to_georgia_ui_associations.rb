class AddRevisionIdToGeorgiaUiAssociations < ActiveRecord::Migration

  def change
    add_column :georgia_ui_associations, :revision_id, :integer
    add_index :georgia_ui_associations, :revision_id
  end

end