class CreateSocieties < ActiveRecord::Migration
  def change
    create_table :societies do |t|
      t.string :description
      t.text :notes
      t.timestamps
    end
  end
end
