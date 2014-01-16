# This migration comes from georgia (originally 7)
class CreateGeorgiaRevisions < ActiveRecord::Migration

  def change
    create_table :georgia_revisions do |t|
      t.string     :state, default: 'draft'
      t.string     :template
      t.references :revisionable, polymorphic: true
      t.timestamps
    end
  end

end