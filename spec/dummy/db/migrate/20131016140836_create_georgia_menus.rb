class CreateGeorgiaMenus < ActiveRecord::Migration

  def change
    create_table :georgia_menus do |t|
      t.string :name
      t.timestamps
    end
  end

end