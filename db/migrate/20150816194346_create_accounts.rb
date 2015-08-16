class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :provider
      t.string :uid
      t.string :encrypted_token
      t.integer :user_id
      t.timestamps
    end
  end
end
