class AddAntiSpamToMessages < ActiveRecord::Migration

  def change
    add_column :georgia_messages, :spam, :boolean, default: false
    add_column :georgia_messages, :verified_at, :datetime
    add_column :georgia_messages, :permalink, :string
    add_column :georgia_messages, :user_ip, :string
    add_column :georgia_messages, :user_agent, :string
    add_column :georgia_messages, :referrer, :string
  end

end