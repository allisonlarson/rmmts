require 'rails_helper'
RSpec.describe "Expenses", type: :feature do
  before do
    society = Society.create(name: "Test")
    User.create(name: "Test User", email: "test@test.com", password: "password", password_confirmation: "password", society: society)
    Expense.create(name: "Electricity", description: "All That Power", amount: 100, society: society)
    visit '/'
    click_on 'Login'
    fill_in 'email', with: "test@test.com"
    fill_in 'password', with: "password"
    click_button "Login"
    click_on "Expenses"
  end

  it "can see all expenses" do
    expect(page).to have_content("Electricity")
    expect(page).to have_content("All That Power")
    expect(page).to have_content("100")
  end

  it "can add a new expense" do
    fill_in "expense[name]", with: "Internet"
    fill_in "expense[description]", with: "A Series of Tubes"
    fill_in "expense[amount]", with: "50"
    click_button "Create Expense"

    expect(page).to have_content("Internet")
    expect(page).to have_content("A Series of Tubes")
    expect(page).to have_content("50")
  end

end
