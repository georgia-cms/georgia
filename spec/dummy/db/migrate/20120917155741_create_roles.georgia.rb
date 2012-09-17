# This migration comes from georgia (originally 20120326154301)
class CreateRoles < ActiveRecord::Migration
  def change
    create_table :georgia_roles do |t|
      t.string :name
      t.timestamps
    end
  end
end
