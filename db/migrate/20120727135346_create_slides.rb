class CreateSlides < ActiveRecord::Migration
	def change
		create_table :georgia_slides do |t|
			t.integer :position
			t.references :page
			t.timestamps
		end
		add_index :georgia_slides, :page_id
	end
end