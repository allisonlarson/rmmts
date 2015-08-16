class AssociateUsersToSocieties < ActiveRecord::Migration
  def change
    add_column :users, :society_id, :integer
  end
end
