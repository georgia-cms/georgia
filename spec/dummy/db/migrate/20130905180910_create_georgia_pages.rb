class CreateGeorgiaPages < ActiveRecord::Migration

  def change
    create_table :georgia_pages do |t|
      t.string    :type
      t.string    :slug
      t.string    :url
      t.integer   :position
      t.integer   :parent_id
      t.integer   :revision_id
      t.string    :ancestry
      t.boolean   :public, default: false
      t.timestamps
    end
    add_index :georgia_pages, :url
    add_index :georgia_pages, :parent_id
    add_index :georgia_pages, :revision_id
    add_index :georgia_pages, :ancestry
  end

end