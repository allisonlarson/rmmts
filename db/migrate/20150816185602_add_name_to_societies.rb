class AddNameToSocieties < ActiveRecord::Migration
  def change
    add_column :societies, :name, :string
  end
end
