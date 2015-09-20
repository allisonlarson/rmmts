class Payment < ActiveRecord::Base
  belongs_to :payee, class_name: "User"
  belongs_to :payer, class_name: "User"
  belongs_to :expense

  scope :paid, -> { where(state: 'paid') }
  scope :unpaid, -> { where.not(state: 'paid') }

  monetize :amount_cents

  state_machine :state, :initial => :pending do
    event :pay do
      transition :from => :pending, :to => :processing
    end

    event :complete do
      transition :from => :processing, :to => :paid
    end
  end
end
