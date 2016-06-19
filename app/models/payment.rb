class Payment < ActiveRecord::Base
  class PaymentError < StandardError; end
  belongs_to :payee, class_name: "User"
  belongs_to :payer, class_name: "User"
  belongs_to :expense

  after_create :use_credit
  after_create :notify_user

  scope :paid, -> { where.not(paid_at: nil) }
  scope :unpaid, -> { where(paid_at: nil) }

  monetize :amount_cents

  def use_credit
    if payer.full_credit?(amount)
      payer.credit!(-amount)
      update_attributes!(paid_at: DateTime.now)
    else
      update_attributes!(amount: amount - payer.credit)
      payer.reset_credit!
    end
  end

  def notify_user
    PaymentMailer.delay.payment_notification_email(self)
  end

  def pay
    response = payer.pay_payment(payee, amount)

    if response == "settled"
      payee.credit!(amount)
      update_attributes!(paid_at: DateTime.now)
    else
      raise PaymentError
    end
  end
end
