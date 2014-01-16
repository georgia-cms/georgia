# This migration comes from georgia (originally 13)
class CreateGeorgiaWidgets < ActiveRecord::Migration

  def change
    create_table :georgia_widgets do |t|
      t.timestamps
    end
  end

end
