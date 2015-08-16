class RemoveAccountInfoFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :uid
    remove_column :users, :encrypted_access_token
  end
end
