class AddFieldsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :street1, :string
    add_column :contacts, :street2, :string
    add_column :contacts, :city, :string
    add_column :contacts, :state, :string
    add_column :contacts, :country, :string
    add_column :contacts, :zip, :integer
    add_column :contacts, :addressable_id, :integer
    add_column :contacts, :addressable_type, :string
  end
end
