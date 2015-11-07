require 'rails_helper'
RSpec.describe Payment do
  it { should belong_to(:payee) }
  it { should belong_to(:payer) }
  it { should belong_to(:expense) }

  describe "#use_credit" do
    let(:payee) { User.create!(email: "test@example.com", password: "password")}
    let(:payer) { User.create!(email: "test2@example.com", password: "password", credit_cents: 500)}
    let(:payment) { Payment.create!(payer: payer, payee: payee, amount_cents: payment_amount)}

    context "payer fully covered" do
      let(:payment_amount) { 100 }

      it "subtracts the credit from the user" do
        expect(payment.payer.credit).to eq(Money.new(400))
      end

      it "marks the payment as completed" do
        expect(payment.paid_at).to be_present
      end
    end

    context "payer paritally covered" do
      let(:payment_amount) { 1000 }

      it "subtracts that credit from the user" do
        expect(payment.payer.credit_cents).to eq(0)
      end

      it "subtracts the credit amount from the request payment" do
        expect(payment.amount).to eq(Money.new(500))
      end

      it "marks the payment as pending" do
        expect(payment.paid_at).to be_nil
      end
    end
  end

  describe "#pay" do
    let(:payee) { User.create!(email: "test@example.com", password: "password")}
    let(:payer) { User.create!(email: "test2@example.com", password: "password")}
    let(:payment) { Payment.create!(payer: payer, payee: payee, amount_cents: 100)}

    subject { payment.pay }

    context "succeeded" do
      it "sets paid_at field" do
        expect(payer).to receive(:pay_payment).with(payee, payment.amount).and_return("settled")
        subject
        expect(payment.paid_at).to be_present
      end
    end

    context "failed" do
      it "throws an error" do
        expect(payer).to receive(:pay_payment).with(payee, payment.amount).and_return("failed")
        expect{ subject }.to raise_error Payment::PaymentError
      end
    end
  end
end
