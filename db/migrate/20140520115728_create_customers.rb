class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :phoneno
      t.integer :fax
      t.string :legal_name
      t.string :website_url

      t.timestamps
    end
  end
end
