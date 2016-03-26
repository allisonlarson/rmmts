class Expense < ActiveRecord::Base
  belongs_to :society
  belongs_to :user
  has_many :payments
  monetize :amount_cents

  def credit_user
    credit_amount = amount - payment_amount(amount)

    user.credit!(credit_amount)
  end

  def paid_at
    payments.order(:paid_at).last.paid_at
  end

  def payment_amount(amount)
    amount / society.users.count
  end
end
