class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :role
      t.string :password_digest
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.has_attached_file :photo
      
      t.timestamps
    end
  end
end
