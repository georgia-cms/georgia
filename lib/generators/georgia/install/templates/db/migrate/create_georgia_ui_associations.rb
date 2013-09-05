class CreateGeorgiaUiAssociations < ActiveRecord::Migration

  def change
    create_table :georgia_ui_associations do |t|
      t.references :page, null: false, index: true
      t.references :widget, null: false, index: true
      t.references :ui_section, null: false, index: true
      t.references :revision, null: false, index: true
      t.integer :position
      t.timestamps
    end
  end

end