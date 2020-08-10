class AddAdminToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :integer, default: 1
  end
end
