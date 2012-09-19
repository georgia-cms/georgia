# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120919105807) do

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "georgia_contents", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.string   "excerpt"
    t.string   "keywords"
    t.string   "locale",           :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "contentable_id"
    t.string   "contentable_type"
    t.integer  "image_id"
  end

  add_index "georgia_contents", ["contentable_type", "contentable_id"], :name => "index_georgia_contents_on_contentable_type_and_contentable_id"
  add_index "georgia_contents", ["image_id"], :name => "index_georgia_contents_on_image_id"
  add_index "georgia_contents", ["locale"], :name => "index_georgia_contents_on_locale"

  create_table "georgia_menu_items", :force => true do |t|
    t.integer "menu_id"
    t.integer "page_id"
    t.integer "position"
    t.boolean "active",   :default => false
  end

  add_index "georgia_menu_items", ["menu_id", "page_id"], :name => "index_georgia_menu_items_on_menu_id_and_page_id"

  create_table "georgia_menus", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "georgia_messages", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "georgia_pages", :force => true do |t|
    t.string   "template",        :default => "one-column"
    t.string   "slug"
    t.integer  "parent_id"
    t.integer  "position"
    t.datetime "published_at"
    t.integer  "published_by_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "georgia_pages", ["parent_id"], :name => "index_georgia_pages_on_parent_id"
  add_index "georgia_pages", ["published_by_id"], :name => "index_georgia_pages_on_published_by_id"

  create_table "georgia_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "georgia_slides", :force => true do |t|
    t.integer  "position"
    t.integer  "page_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "georgia_slides", ["page_id"], :name => "index_georgia_slides_on_page_id"

  create_table "georgia_ui_associations", :force => true do |t|
    t.integer  "page_id",       :null => false
    t.integer  "widget_id",     :null => false
    t.integer  "ui_section_id", :null => false
    t.integer  "position"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "georgia_ui_associations", ["page_id"], :name => "index_georgia_ui_associations_on_page_id"
  add_index "georgia_ui_associations", ["ui_section_id"], :name => "index_georgia_ui_associations_on_ui_section_id"
  add_index "georgia_ui_associations", ["widget_id"], :name => "index_georgia_ui_associations_on_widget_id"

  create_table "georgia_ui_sections", :force => true do |t|
    t.string "name"
  end

  create_table "georgia_users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "georgia_users", ["email"], :name => "index_georgia_users_on_email", :unique => true
  add_index "georgia_users", ["reset_password_token"], :name => "index_georgia_users_on_reset_password_token", :unique => true

  create_table "georgia_widgets", :force => true do |t|
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :null => false
    t.integer "user_id", :null => false
  end

  add_index "roles_users", ["user_id", "role_id"], :name => "index_roles_users_on_user_id_and_role_id"

end
