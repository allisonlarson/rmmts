require 'rails_helper'

RSpec.describe Expense do

  it { should belong_to(:user) }
  it { should belong_to(:society) }
  it { should have_many(:payments) }

  describe "#state" do
    let(:expense) { Expense.create! }

    context "with successful payments" do
      let!(:payment1) { Payment.create!(expense: expense, state: 'success') }
      let!(:payment2) { Payment.create!(expense: expense, state: 'success') }

      it "returns success" do
        expect(expense.state).to eq('success')
      end
    end

    context "with unsuccessful payments" do
      let!(:payment1) { Payment.create!(expense: expense, state: 'success') }
      let!(:payment2) { Payment.create!(expense: expense, state: 'pending') }

      it "returns pending" do
        expect(expense.state).to eq('pending')
      end

    end
  end
end
