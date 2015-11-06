class Expense < ActiveRecord::Base
  belongs_to :society
  belongs_to :user
  has_many :payments
  monetize :amount_cents

  def build_payments
    society.users.each do |payment_user|
      next if payment_user == self.user
      amount = payment_amount(amount_cents)

      payments.new(
        payee: self.user,
        payer: payment_user,
        amount_cents: amount
      )

      self.user.credit!(amount, payment_user)
      payment_user.credit!(-amount, self.user)
    end
  end

  private

  def payment_amount(amount)
    amount / society.users.count
  end
end
