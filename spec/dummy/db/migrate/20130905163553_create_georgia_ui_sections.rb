class CreateGeorgiaUiSections < ActiveRecord::Migration

  def change
    create_table :georgia_ui_sections do |t|
      t.string :name
    end
  end

end