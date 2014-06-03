class AddAddressTypeToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :address_type, :string
  end
end
