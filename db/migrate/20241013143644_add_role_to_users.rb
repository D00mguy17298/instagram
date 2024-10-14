class AddRoleToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :admin, :boolean
    add_column :users, :role, :string
  end
end
