class CreateGeorgiaMessages < ActiveRecord::Migration

  def change
    create_table :georgia_messages do |t|
      t.string  :name
      t.string  :email
      t.string  :phone
      t.string  :subject
      t.string  :attachment
      t.text    :message
      t.boolean :spam, default: false
      t.timestamps
    end
  end

end