class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_secure_password

  validates :email, presence: true, uniqueness: true

  belongs_to :society
  has_many :accounts, dependent: :destroy
  has_many :expenses
end
