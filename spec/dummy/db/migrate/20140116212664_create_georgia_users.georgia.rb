# This migration comes from georgia (originally 12)
class CreateGeorgiaUsers < ActiveRecord::Migration

  def change
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

      t.timestamps
    end
    add_index :georgia_users, :email,                :unique => true
    add_index :georgia_users, :reset_password_token, :unique => true
  end

end