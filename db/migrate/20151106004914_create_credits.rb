class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :amount, default: 0, null: false
      t.integer :owner_id
      t.integer :user_id
    end
  end
end
