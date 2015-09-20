require 'rails_helper'

RSpec.describe ExpensesController do
  describe "#create" do
    before do
      society = Society.create(name: "Test")
      User.create(name: "Test User", email: "test@test.com", password: "password", password_confirmation: "password", society: society)
      User.create(name: "Other User", email: "other@test.com", password: "password", password_confirmation: "password", society: society)
    end

    it "builds payments from expense" do
      ApplicationController.any_instance.stub(:current_society).and_return(society)
      post :create, expense: { name: "Electricity", description: "All That Power", amount: 100 }

      expense = Expense.last
      expect(expense.payments.count).to be(1)
      expect(expense.payments.last.amount).to be(50)
    end
  end
end
