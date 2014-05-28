class CreateGeorgiaContents < ActiveRecord::Migration

  def change
    create_table :georgia_contents do |t|
      t.string :locale, null: false
      t.string :title
      t.text :text
      t.text :excerpt
      t.references :contentable, polymorphic: true, index: true
      t.references :image, index: true
      t.timestamps
    end
    add_index :georgia_contents, :locale
  end

end