require 'rails_helper'
RSpec.describe Payment do
  it { should belong_to(:payee) }
  it { should belong_to(:payer) }
  it { should belong_to(:expense) }

  describe "#use_credit" do
    let!(:payee) { User.create!(email: "test@example.com", password: "password")}
    let!(:payer) { User.create!(email: "test2@example.com", password: "password", credit_cents: 500)}

    context "payer full covered" do
      before do
        @payment = Payment.create!(payer: payer, payee: payee, amount_cents: 100)
      end

      it "subtracts the credit from the user" do
        expect(@payment.payer.credit).to eq(Money.new(400))
      end

      it "marks the payment as completed" do
        expect(@payment.state).to eq('success')
      end
    end

    context "payer paritally covered" do
      before do
        @payment = Payment.create!(payer: payer, payee: payee, amount_cents: 1000)
      end

      it "subtracts that credit from the user" do
        expect(@payment.payer.credit_cents).to eq(0)
      end

      it "subtracts the credit amount from the request payment" do
        expect(@payment.amount).to eq(Money.new(500))
      end

      it "marks the payment as pending" do
        expect(@payment.state).to eq('pending')
      end
    end
  end
end
