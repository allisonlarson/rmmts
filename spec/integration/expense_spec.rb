require 'rails_helper'
RSpec.describe "Expenses", type: :feature do
  let(:society) { Society.create!(name: "Test") }
  let!(:user) { User.create!(name: "Test User", email: "test@test.com", password: "password", password_confirmation: "password", society: society) }
  let!(:user2) { User.create!(name: "Other User", email: "other@test.com", password: "password", password_confirmation: "password", society: society) }
  let(:expense) { Expense.create!(name: "Electricity", description: "All That Power", amount: 100, society: society, user: user) }

  context "existing expenses" do
    before do
      expense.build_payments && expense.save!
      visit '/'
      login
      click_on "Expenses"
    end

    it "can see all expenses" do
      expect(page).to have_content("Electricity")
      expect(page).to have_content("All That Power")
      expect(page).to have_content("100")
    end
  end

  context "adding a new expense" do
    before do
      visit '/'
      login
      click_on "Expenses"
      fill_in "expense[name]", with: "Internet"
      fill_in "expense[description]", with: "A Series of Tubes"
      fill_in "expense[amount]", with: "50"
      click_button "Create Expense"
    end

    context "the creating user" do
      it "can add a new expense" do
        expect(page).to have_content("Internet")
        expect(page).to have_content("A Series of Tubes")
        expect(page).to have_content("50")
      end

      it "shows total owed of expense" do
        within('.balance') do
          expect(page).to have_content("-25.00")
        end
      end
    end

    context "the requested user" do
      before do
        click_on "Logout"
        login("other@test.com")
        click_on "Payments"
      end

      it "adds payments for users from expense" do
        expect(page).to have_content("Internet")
        expect(page).to have_content("25")
      end

      it "shows total owed" do
        within('.balance') do
          expect(page).to have_content("25.00")
        end
      end
    end
  end
end
