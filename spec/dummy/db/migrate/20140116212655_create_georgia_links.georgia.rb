# This migration comes from georgia (originally 3)
class CreateGeorgiaLinks < ActiveRecord::Migration

  def change
    create_table :georgia_links do |t|
      t.integer :menu_id
      t.integer :position
      t.string :ancestry
    end
    add_index :georgia_links, :ancestry
  end

end