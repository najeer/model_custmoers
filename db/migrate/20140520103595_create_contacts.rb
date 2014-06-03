class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.integer :phone_no
      t.integer :mobile
      t.string :linkedn_url
      t.string :facebook_url
      t.string :twitter_url
      t.integer :customer_id

      t.timestamps
    end
  end
end
