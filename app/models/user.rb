class User < ActiveRecord::Base
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :lockable
  friendly_id :name, use: :slugged

  belongs_to :society
  has_many :accounts, dependent: :destroy
  has_many :expenses
  has_many :payments, class_name: 'Payment', foreign_key: 'payer_id'
  has_many :collections, class_name: 'Payment', foreign_key: 'payee_id'

  def expense_amount
    expenses.inject(0) { |sum, e| sum + e.amount }
  end

  def paid_amount
    payments.paid.inject(0) { |sum, e| sum + e.amount }
  end

  def unpaid_amount
    payments.unpaid.inject(0) { |sum, e| sum + e.amount }
  end

  def collected_amount
    collections.paid.inject(0) { |sum, e| sum + e.amount }
  end

  def uncollected_amount
    collections.unpaid.inject(0) { |sum, e| sum + e.amount }
  end

end
