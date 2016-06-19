class User < ActiveRecord::Base
  class PaymentError < StandardError; end
  extend FriendlyId
  devise :invitable, :database_authenticatable, :registerable,
    :async, :recoverable, :rememberable, :trackable, :validatable, :lockable
  friendly_id :name, use: :slugged
  monetize :credit_cents

  belongs_to :society
  has_many :accounts, dependent: :destroy
  has_many :expenses
  has_many :payments, class_name: 'Payment', foreign_key: 'payer_id'
  has_many :collections, class_name: 'Payment', foreign_key: 'payee_id'

  def pay_payment(payee, amount)
    default_account.make_payment(payee.uid, amount)
  end

  def uid
    default_account.try(:uid)
  end

  def default_account
    accounts.first
  end

  def total_owed
    unpaid_amount
  end

  def expense_amount
    expenses.inject(Money.new(0)) { |sum, e| sum + e.amount }
  end

  def paid_amount
    payments.paid.inject(Money.new(0)) { |sum, e| sum + e.amount }
  end

  def unpaid_amount
    payments.unpaid.inject(Money.new(0)) { |sum, e| sum + e.amount }
  end

  def collected_amount
    collections.paid.inject(Money.new(0)) { |sum, e| sum + e.amount }
  end

  def uncollected_amount
    collections.unpaid.inject(Money.new(0)) { |sum, e| sum + e.amount }
  end
end
