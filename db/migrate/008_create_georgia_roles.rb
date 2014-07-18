class CreateGeorgiaRoles < ActiveRecord::Migration

  def up
    create_table :georgia_roles do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
    drop_table :georgia_roles
  end

end