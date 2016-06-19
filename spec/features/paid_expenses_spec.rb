require 'rails_helper'
RSpec.describe "Paying Expenses", type: :feature do
  let(:society) { Society.create!(name: "Test") }
  let!(:user) { User.create!(name: "Test User", email: "test@test.com", password: "password", password_confirmation: "password", society: society) }
  let!(:user2) { User.create!(name: "Other User", email: "other@test.com", password: "password", password_confirmation: "password", society: society) }
  let!(:account) { Account.create!(provider: "test", uid: "145434160922624933", token: "1234", user: user2) }


  scenario "should reset credits to 0" do
    expect(HTTP).to receive(:post).once.and_return(successful_response(25.00))
    visit '/'
    login
    click_on "Expenses"
    fill_in "expense[name]", with: "Internet"
    fill_in "expense[description]", with: "A Series of Tubes"
    fill_in "expense[amount]", with: "50"
    click_button "Create Expense"

    expect(page).to have_content("Internet")
    expect(page).to have_content("A Series of Tubes")
    expect(page).to have_content("50")
    within('.balance') do
      expect(page).to have_content("-25.00")
    end

    click_on "Logout"
    login("other@test.com")
    click_on "Payments"
    expect(page).to have_content("Internet")
    expect(page).to have_content("25.00")

    within('.balance') do
      expect(page).to have_content("25.00")
    end
    click_on "Pay"
    within(".payments-table") do
      expect(page).to have_content(DateTime.now.strftime("%m/%d/%Y"))
      expect(page).to_not have_link("Pay")
    end
    within('.balance') do
      expect(page).to have_content("0.00")
    end

    click_on "Logout"
    login
    within('.balance') do
      expect(page).to have_content("0.00")
    end
  end
end
