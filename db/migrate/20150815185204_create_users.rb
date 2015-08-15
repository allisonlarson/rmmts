class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :uid
      t.string :encrypted_access_token
      t.string :image
      t.integer :balance

      t.timestamps
    end
  end
end
