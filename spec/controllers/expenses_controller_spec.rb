require 'rails_helper'

RSpec.describe ExpensesController do
  describe "#create" do
    let(:society) { Society.create(name: "Test") }
    let(:user)  { User.create(name: "Test User", email: "test@test.com", password: "password", password_confirmation: "password", society: society) }

    before do
      allow(controller).to receive(:current_society) { society }
      User.create(name: "Other User", email: "other@test.com", password: "password", password_confirmation: "password", society: society)
      sign_in user
    end

    it "builds payments from expense" do
      post :create, {society_id: society.id, expense: { name: "Electricity", description: "All That Power", amount: 100 } }

      expense = Expense.last
      expect(expense.payments.count).to eq(1)
      expect(expense.payments.last.amount).to eq(50)
    end
  end
end
