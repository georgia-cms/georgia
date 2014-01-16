# This migration comes from georgia (originally 5)
class CreateGeorgiaMessages < ActiveRecord::Migration

  def change
    create_table :georgia_messages do |t|
      t.string   :name
      t.string   :email
      t.string   :phone
      t.string   :subject
      t.string   :attachment
      t.text     :message
      t.boolean  :spam, default: false
      t.datetime :verified_at
      t.string   :permalink
      t.string   :user_ip
      t.string   :user_agent
      t.string   :referrer
      t.timestamps
    end
  end

end