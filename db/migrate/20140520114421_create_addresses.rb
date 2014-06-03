class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :location
      t.integer :custmer_id
      t.string :country
      t.integer :zip
      t.string :address_type
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps
    end
  end
end
