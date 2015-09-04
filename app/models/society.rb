class Society < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :users
  validates :name, presence: true, uniqueness: true
  accepts_nested_attributes_for :users
end
