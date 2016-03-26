module Builders
  class Expense

    def initialize(expense)
      @expense = expense
      @society = expense.society
      @user = expense.user
      @amount = expense.amount_cents
    end

    def build_payments_from_expense
      @society.users.each do |payment_user|
        next if payment_user == @user

        @expense.payments.new(
          payee: @user,
          payer: payment_user,
          amount_cents: @expense.payment_amount(@amount)
        )
      end
    end
  end
end
