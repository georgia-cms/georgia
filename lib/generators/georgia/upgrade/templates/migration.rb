class UpgradeGeorgia < ActiveRecord::Migration

  def up
    create_table :tags do |t|
      t.string :name
    end

    create_table :taggings do |t|
      t.references :tag
      t.references :taggable, :polymorphic => true
      t.references :tagger, :polymorphic => true
      t.string :context, :limit => 128
      t.datetime :created_at
    end

    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type, :context]

    remove_column :georgia_links, :dropdown
    remove_column :georgia_links, :page_id

    if index_exists?(:georgia_links, [:menu_id, :page_id])
      remove_index :georgia_links, [:menu_id, :page_id]
    end

    add_column :georgia_links, :ancestry, :string
    add_index :georgia_links, :ancestry
  end

  def down
    drop_table :tags
    drop_table :taggings
    remove_index :taggings, :tag_id
    remove_index :taggings, [:taggable_id, :taggable_type, :context]

    add_column :georgia_links, :dropdown, :boolean
    add_column :georgia_links, :page_id, :integer
    add_index :georgia_links, [:menu_id, :page_id]

    remove_column :georgia_links, :ancestry
    remove_index  :georgia_links, :ancestry
  end

end