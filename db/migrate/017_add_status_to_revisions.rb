class AddStatusToRevisions < ActiveRecord::Migration

  def change
    add_column :georgia_revisions, :status, :integer, default: 0
  end

end