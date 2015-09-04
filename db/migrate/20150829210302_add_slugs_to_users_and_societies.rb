class AddSlugsToUsersAndSocieties < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string, uniq: true
    add_column :societies, :slug, :string, uniq: true
  end
end
