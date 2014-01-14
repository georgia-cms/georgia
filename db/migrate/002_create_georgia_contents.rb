class CreateGeorgiaContents < ActiveRecord::Migration

  def change
    create_table :georgia_contents do |t|
      t.string :locale, null: false
      t.string :title
      t.text :text
      t.text :excerpt
      t.references :contentable, polymorphic: true
      t.integer :image_id
      t.timestamps
    end
    add_index :georgia_contents, [:contentable_type, :contentable_id]
    add_index :georgia_contents, :locale
    add_index :georgia_contents, :image_id
  end

end