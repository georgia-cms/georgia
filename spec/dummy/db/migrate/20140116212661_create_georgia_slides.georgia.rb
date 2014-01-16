# This migration comes from georgia (originally 9)
class CreateGeorgiaSlides < ActiveRecord::Migration

  def change
    create_table :georgia_slides do |t|
      t.integer :position
      t.references :page, index: true
      t.timestamps
    end
  end

end