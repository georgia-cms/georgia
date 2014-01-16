# This migration comes from georgia (originally 8)
class CreateGeorgiaRoles < ActiveRecord::Migration

  def up
    create_table :georgia_roles do |t|
      t.string :name
      t.timestamps
    end
    Georgia::Role.create(name: 'Admin')
    Georgia::Role.create(name: 'Editor')
  end

  def down
    drop_table :georgia_roles
  end

end