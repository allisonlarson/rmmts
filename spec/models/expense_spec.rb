require 'rails_helper'

RSpec.describe Expense do

  it { should belong_to(:user) }
  it { should belong_to(:society) }
  it { should have_many(:payments) }

  describe "#build_payments" do
    context "with multiple roommates" do
      let!(:society) { Society.create!(name: "test") }
      let!(:expense) { Expense.create!(amount_cents: 5000, user: user1, society: society)}
      let!(:user1) { User.create!(email: "test@example.com", password: "password", society: society)}
      let!(:user2) { User.create!(email: "test2@example.com", password: "password", society: society)}
      let!(:user3) { User.create!(email: "test3@example.com", password: "password", society: society)}

      it "builds new payments" do
        expense.build_payments
        expect{ expense.save! }.to change{ Payment.count }.by(2)
        payment = Payment.last
        expect(payment.amount_cents).to eq(1666)
        expect(payment.payee).to eq(user1)
        expect(payment.payer).to eq(user3)
      end
    end
  end

  describe "#credit_user" do
    let!(:society) { Society.create!(name: "test") }
    let!(:expense) { Expense.create!(amount_cents: 7500, user: user1, society: society)}
    let!(:user1) { User.create!(email: "test@example.com", password: "password", society: society)}
    let!(:user2) { User.create!(email: "test2@example.com", password: "password", society: society)}
    let!(:user3) { User.create!(email: "test3@example.com", password: "password", society: society)}

    it "credits the user" do
      expense.credit_user
      expect(user1.credit).to eq(Money.new(5000))
    end
  end
end

