class Expense < ActiveRecord::Base
  belongs_to :society
  belongs_to :user
  has_many :payments
  monetize :amount_cents

  def build_payments
    society.users.each do |payment_user|
      next if payment_user == self.user

      payments.new(
        payee: self.user,
        payer: payment_user,
        amount_cents: payment_amount(amount_cents)
      )
    end
  end

  def credit_user
    user.credit += (amount - payment_amount(amount))
    user.save!
  end

  private

  def payment_amount(amount)
    amount / society.users.count
  end
end
