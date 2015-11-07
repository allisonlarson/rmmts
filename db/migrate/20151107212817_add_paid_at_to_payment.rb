class AddPaidAtToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :paid_at, :datetime
    remove_column :payments, :state
  end
end
