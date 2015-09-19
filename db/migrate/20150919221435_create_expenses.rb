class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :amount
      t.integer :society_id
      t.integer :user_id
      t.string  :name
      t.text    :description
    end
  end
end
