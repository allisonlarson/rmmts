require 'spec_helper'

RSpec.describe PaymentMailer do
  describe "#payment_notification_email" do
    let(:payee) { User.create!(email: "test@example.com", password: "password", name: "Test")}
    let(:payer) { User.create!(email: "test2@example.com", password: "password", name: "Other", credit_cents: 500)}
    let(:payment) { Payment.create!(payer: payer, payee: payee, amount_cents: 100) }
    let(:mail) { PaymentMailer.payment_notification_email(payment) }

    it "renders the subject" do
      expect(mail.subject).to eq("#{payee.name} has requested a payment")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([payer.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(['notifications@rmmts.com'])
    end
  end
end
