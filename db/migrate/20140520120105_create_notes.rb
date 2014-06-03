class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :category
      t.string :description
      t.interger :customer_id
      t.string :notable_type
      t.integer :notable_id

      t.timestamps
    end
  end
end
