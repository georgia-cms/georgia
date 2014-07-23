class RemoveGeorgiaRevisionsState < ActiveRecord::Migration

  def self.up
    remove_column :georgia_revisions, :state
  end

  def self.down
    add_column :georgia_revisions, :state, :string, default: 'draft'
  end

end