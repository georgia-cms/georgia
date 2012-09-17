class CreatePages < ActiveRecord::Migration
  def change
    create_table :georgia_pages do |t|
      t.string :template, default: 'one-column'
      t.string :slug
      t.integer :parent_id
      t.integer :position
      t.datetime :published_at
      t.integer :published_by_id
      t.timestamps
    end
    add_index :georgia_pages, :parent_id
    add_index :georgia_pages, :published_by_id
  end
end