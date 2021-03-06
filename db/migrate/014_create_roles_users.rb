class CreateRolesUsers < ActiveRecord::Migration

  def change
    create_table :roles_users, id: false do |t|
      t.references :role, null: false
      t.references :user, null: false
    end
    add_index :roles_users, [:user_id, :role_id]
  end

end