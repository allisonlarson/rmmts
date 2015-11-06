class Credit < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  belongs_to :user, class_name: "User"
end
