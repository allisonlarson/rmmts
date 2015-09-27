class Payment < ActiveRecord::Base
  class PaymentError < StandardError; end
  belongs_to :payee, class_name: "User"
  belongs_to :payer, class_name: "User"
  belongs_to :expense

  scope :paid, -> { where(state: 'paid') }
  scope :unpaid, -> { where.not(state: 'paid') }

  monetize :amount_cents

  state_machine :state, :initial => :pending do
    event :succeed do
      transition :from => :pending, :to => :success
    end

    event :failed do
      transition :from => :processing, :to => :failure
    end
  end

  def pay
    response = account.make_payment!(payee.uid, amount)

    if response == "settled"
      self.succeed!
    elsif response == "failed"
      self.failed!
    else
      throw PaymentError
    end
  end
end
