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

  def pay
    payments.unpaid.group_by(&:payee_id).each do |user_id, payments|
      uid = User.find(user_id).accounts.first.uid
      payment_amount = payments.inject(0) { |sum, e| sum + e.amount }
      response = default_account.make_payment(uid, payment_amount)

      if response == "settled"
        payments.each(&:succeed!)
      else
        throw PaymentError
      end
    end
  end

  def default_account
    accounts.first
  end

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
