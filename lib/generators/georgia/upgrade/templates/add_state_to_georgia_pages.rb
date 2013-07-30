class AddStateToGeorgiaPages < ActiveRecord::Migration

  def up
    add_column  :georgia_pages, :state, :string
    add_index   :georgia_pages, :state
  end

  def down
    remove_column :georgia_pages, :state
    remove_index  :georgia_pages, :state
  end

end