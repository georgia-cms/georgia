class ChangeGeorgiaContentExcerptToText < ActiveRecord::Migration

  def up
    change_column :georgia_contents, :excerpt, :text
  end

  def down
    change_column :georgia_contents, :excerpt, :string
  end

end