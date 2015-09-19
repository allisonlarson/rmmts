class Expense < ActiveRecord::Base
  belongs_to :society
  belongs_to :user

end
