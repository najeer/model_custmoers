class AddStatusToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :status, :integer, :default=>1
  end
end
