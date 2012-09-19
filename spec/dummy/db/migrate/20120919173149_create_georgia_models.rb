class CreateGeorgiaModels < ActiveRecord::Migration
  def up
    # Create Roles
    create_table :georgia_roles do |t|
      t.string :name
      t.timestamps
    end
    # Create RolesUsers Association Table
    create_table :roles_users, id: false do |t|
      t.references :role, null: false
      t.references :user, null: false
    end
    add_index :roles_users, [:user_id, :role_id]

    # Create Messages
    create_table :georgia_messages do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :message

      t.timestamps
    end

    # Create Pages
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

    # Create Content
    create_table :georgia_contents do |t|
      t.string :title
      t.text :text
      t.string :excerpt
      t.string :keywords
      t.string :locale, null: false
      t.timestamps
      t.references :contentable, polymorphic: true
      t.integer :image_id
    end
    add_index :georgia_contents, [:contentable_type, :contentable_id]
    add_index :georgia_contents, :locale
    add_index :georgia_contents, :image_id


    # Create Slides
    create_table :georgia_slides do |t|
      t.integer :position
      t.references :page
      t.timestamps
    end
    add_index :georgia_slides, :page_id

    # Create Ckeditor Assets
    create_table :ckeditor_assets do |t|
      t.string  :data_file_name, :null => false
      t.string  :data_content_type
      t.integer :data_file_size
      
      t.integer :assetable_id
      t.string  :assetable_type, :limit => 30
      t.string  :type, :limit => 30
      
      # Uncomment it to save images dimensions, if your need it
      t.integer :width
      t.integer :height
      
      t.timestamps
    end
    add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"
    add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"

    # Create Users
    create_table :georgia_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token

      t.timestamps
    end

    add_index :georgia_users, :email,                :unique => true
    add_index :georgia_users, :reset_password_token, :unique => true
    # add_index :georgia_users, :confirmation_token,   :unique => true
    # add_index :georgia_users, :unlock_token,         :unique => true
    # add_index :georgia_users, :authentication_token, :unique => true

    # Create UI Sections
    create_table :georgia_ui_sections do |t|
      t.string :name
    end

    # Create Widgets
    create_table :georgia_widgets do |t|
      t.integer :position
      t.timestamps
    end

    # Create UI Associations
    create_table :georgia_ui_associations do |t|
      t.references :page, null: false
      t.references :widget, null: false
      t.references :ui_section, null: false
      t.integer :position
      t.timestamps
    end
    add_index :georgia_ui_associations, :page_id
    add_index :georgia_ui_associations, :widget_id
    add_index :georgia_ui_associations, :ui_section_id

    # Create Navigation Menus
    create_table :georgia_menus do |t|
      t.string :name
      t.timestamps
    end

    # Create Navigation Menus Items
    create_table :georgia_menu_items do |t|
      t.integer :menu_id
      t.integer :page_id
      t.integer :position
      t.boolean :active, default: false
    end
    add_index :georgia_menu_items, [:menu_id, :page_id]


    # Create Status
    create_table :georgia_statuses do |t|
      t.string :name
      t.string :label
      t.string :icon
      t.references :statusable, polymorphic: true
    end
    add_index :georgia_statuses, [:statusable_type, :statusable_id]

  end

  def down
    drop_table :georgia_roles
    drop_table :roles_users
    drop_table :georgia_messages
    drop_table :georgia_pages
    drop_table :georgia_contents
    drop_table :georgia_slides
    drop_table :ckeditor_assets
    drop_table :georgia_users
    drop_table :georgia_ui_sections
    drop_table :georgia_widgets
    drop_table :georgia_ui_associations
    drop_table :georgia_menus
    drop_table :georgia_menu_items
    drop_table :georgia_statuses
    remove_index :roles_users, [:user_id, :role_id]
    remove_index :georgia_pages, :parent_id
    remove_index :georgia_pages, :published_by_id
    remove_index :georgia_contents, [:contentable_type, :contentable_id]
    remove_index :georgia_contents, :locale
    remove_index :georgia_contents, :image_id
    remove_index :georgia_slides, :page_id
    remove_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"]
    remove_index "ckeditor_assets", ["assetable_type", "assetable_id"]
    remove_index :georgia_users, :email
    remove_index :georgia_users, :reset_password_token
    remove_index :georgia_ui_associations, :page_id
    remove_index :georgia_ui_associations, :widget_id
    remove_index :georgia_ui_associations, :ui_section_id
    remove_index :georgia_menu_items, [:menu_id, :page_id]
    remove_index :georgia_statuses, [:statusable_type, :statusable_id]
  end
end