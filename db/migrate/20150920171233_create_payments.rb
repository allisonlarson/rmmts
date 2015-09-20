class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :amount_cents, null: false, default: 0
      t.integer :payee_id
      t.integer :payer_id
      t.integer :expense_id
      t.string :state
    end
  end
end
