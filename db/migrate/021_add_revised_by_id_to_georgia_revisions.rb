class AddRevisedByIdToGeorgiaRevisions < ActiveRecord::Migration

  def self.up
    add_column :georgia_revisions, :revised_by_id, :integer
    add_index :georgia_revisions, :revised_by_id
  end

  def self.down
    remove_column :georgia_revisions, :revised_by_id
    remove_index :georgia_revisions, :revised_by_id
  end

end