require 'rails_helper'
RSpec.describe "Expenses", type: :feature do
  before do
    @society = Society.create!(name: "Test")
    @user = User.create!(name: "Test User", email: "test@test.com", password: "password", password_confirmation: "password", society: @society)
    @user2 = User.create!(name: "Other User", email: "other@test.com", password: "password", password_confirmation: "password", society: @society)
  end

  context "existing expenses" do
    before do
      Expense.create(name: "Electricity", description: "All That Power", amount: 100, society: @society, user: @user)
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

    it "can add a new expense" do
      expect(page).to have_content("Internet")
      expect(page).to have_content("A Series of Tubes")
      expect(page).to have_content("50")
    end

    it "adds payments for users from expense" do
      click_on "Logout"
      login("other@test.com")
      click_on "Payments"

      expect(page).to have_content("Internet")
      expect(page).to have_content("25")
    end
  end
end
