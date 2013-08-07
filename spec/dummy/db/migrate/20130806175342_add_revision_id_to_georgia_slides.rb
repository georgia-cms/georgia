class AddRevisionIdToGeorgiaSlides < ActiveRecord::Migration

  def change
    add_column :georgia_slides, :revision_id, :integer
    add_index :georgia_slides, :revision_id
  end

end