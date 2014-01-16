# This migration comes from georgia (originally 11)
class CreateGeorgiaUiSections < ActiveRecord::Migration

  def up
    create_table :georgia_ui_sections do |t|
      t.string :name
    end
    Georgia::UiSection.create(name: 'Footer')
    Georgia::UiSection.create(name: 'Sidebar')
  end

  def down
    drop_table :georgia_ui_sections
  end

end