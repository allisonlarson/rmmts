require 'rails_helper'

RSpec.describe Builders::Expense do
  context "expense between multiple roommates" do
    let(:society) { Society.create!(name: "test") }
    let(:expense) { Expense.create!(amount_cents: 5000, user: user1, society: society)}
    let!(:user1) { User.create!(email: "test@example.com", password: "password", society: society)}
    let!(:user2) { User.create!(email: "test2@example.com", password: "password", society: society)}
    let!(:user3) { User.create!(email: "test3@example.com", password: "password", society: society)}
    let(:builder) { Builders::Expense.new(expense) }


    describe "#build_payments_from_expense" do
      subject { builder.build_payments_from_expense }

      it "builds new payments" do
        subject

        expect{ expense.save! }.to change{ Payment.count }.by(2)
        payment = Payment.last
        expect(payment.amount_cents).to eq(1666)
        expect(payment.payee).to eq(user1)
        expect(payment.payer).to eq(user3)
      end
    end
  end
end
