require 'rails_helper'
RSpec.describe "Payments", type: :feature do
  let(:society) { Society.create!(name: "Test") }
  let!(:user) { User.create!(name: "Test User", email: "test@test.com", password: "password", password_confirmation: "password", society: society) }
  let!(:user2) { User.create!(name: "Other User", email: "other@test.com", password: "password", password_confirmation: "password", society: society) }
  let(:expense) { Expense.create!(name: "Electricity", description: "All That Power", amount: 100, society: society, user: user2) }
  let!(:account) { Account.create!(provider: "test", uid: "145434160922624933", token: "1234", user: user) }

  context "singular payment" do
    before do
      Builders::Expense.new(expense).build_payments_from_expense
      expense.save!
      visit '/'
    end

    context "that must be paid" do
      before do
        login(user.email)
        click_on "Payments"
      end

      it "can pay payment" do
        expect_any_instance_of(Account).to receive(:make_payment).and_return("settled")

        within(".payments-table") do
          expect(page).to_not have_content(DateTime.now.strftime("%m/%d/%Y"))
          expect(page).to have_link("Pay")
        end

        click_on "Pay"
        within(".payments-table") do
          expect(page).to have_content(DateTime.now.strftime("%m/%d/%Y"))
          expect(page).to_not have_link("Pay")
        end
      end
    end

    context "that must be collected" do
      before do
        login(user2.email)
        click_on "Payments"
      end

      it "can mark requested payment as paid" do
        click_on "Mark as Paid"

        within(".collections-table") do
          expect(page).to have_content(DateTime.now.strftime("%m/%d/%Y"))
          expect(page).to_not have_link("Mark as Paid")
        end
      end
    end
  end
end
