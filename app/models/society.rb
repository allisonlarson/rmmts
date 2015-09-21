class Society < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :users
  has_many :expenses
  validates :name, presence: true, uniqueness: true
end
