class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true

  belongs_to :society
  has_many :accounts, dependent: :destroy
end
