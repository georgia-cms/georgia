class AddRoleIdToUsers < ActiveRecord::Migration

  def change
    add_column :georgia_users, :role_id, :integer, index: true
  end

end