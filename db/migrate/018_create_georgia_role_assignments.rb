class CreateGeorgiaRoleAssignments < ActiveRecord::Migration

  def change
    create_table :georgia_role_assignments do |t|
      t.references :role, null: false, index: true
      t.references :user, null: false, index: true
      t.timestamps
    end
  end

end