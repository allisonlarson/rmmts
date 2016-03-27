require 'rails_helper'
RSpec.describe Payment do
  it { should belong_to(:payee) }
  it { should belong_to(:payer) }
  it { should belong_to(:expense) }

  let(:payee) { User.create!(email: "test@example.com", password: "password", credit_cents: -100)}
  let(:payer) { User.create!(email: "test2@example.com", password: "password", credit_cents: 500)}
  let(:payment) { Payment.create!(payer: payer, payee: payee, amount_cents: payment_amount)}

  describe "#pay" do
    let!(:payment_amount) { 100 }

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

  describe "#mark_paid" do
    let!(:payment_amount) { 100 }

    subject { payment.mark_paid }

    it "marks as paid" do
      subject
      expect(payment.paid_at).to_not be_nil
    end
  end
end
