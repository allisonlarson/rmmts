require 'rails_helper'
RSpec.describe Payment do
  it { should belong_to(:payee) }
  it { should belong_to(:payer) }
  it { should belong_to(:expense) }

  describe "#pay" do
    let!(:user) { User.create(email: "test@example.com", password: "password")}
    let!(:other) { User.create(email: "other@example.com", password: "password")}
    let!(:account) { Account.create(user: other, uid: '123')}
    let!(:payment) { Payment.create(payer: user, payee: other, amount: 100) }

    context "succeeds" do
      before do
        expect(user).to receive(:make_payment!).and_return('settled')
        payment.pay
      end

      it "credits the payer" do
        expect(user.credits.find_by(user: other).amount).to eq(100)
      end

      it "takes credit from payee" do
        expect(other.credits.find_by(user: user).amount).to eq(-100)
      end

      it "sets payment to success" do
        expect(payment.state).to eq('success')
      end
    end

    context "failed" do
      before do
        expect(user).to receive(:make_payment!).and_return('failed')
        payment.pay
      end

      it "does sets payment to failed" do
        expect(payment.state).to eq('failure')
      end
    end

  end
end
