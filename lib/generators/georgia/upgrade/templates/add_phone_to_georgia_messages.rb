class AddPhoneToGeorgiaMessages < ActiveRecord::Migration

  def up
    add_column :georgia_messages, :phone, :string
  end

  def down
    remove_column :georgia_messages, :phone
  end

end