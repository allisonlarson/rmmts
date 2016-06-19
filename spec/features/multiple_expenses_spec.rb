require 'rails_helper'
RSpec.describe "Paying Expenses", type: :feature do
  let(:society) { Society.create!(name: "Test") }
  let!(:user) { User.create!(name: "Test User", email: "test@test.com", password: "password", password_confirmation: "password", society: society) }
  let!(:user2) { User.create!(name: "Other User", email: "other@test.com", password: "password", password_confirmation: "password", society: society) }
  let!(:user3) { User.create!(name: "OtherOther User", email: "otherother@test.com", password: "password", password_confirmation: "password", society: society) }
  let!(:account) { Account.create!(provider: "test", uid: "145434160922624933", token: "1234", user: user3) }


  scenario "should record expenses correctly" do
    expect(HTTP).to receive(:post).once.and_return(successful_response(25.00))
    visit '/'
    login
    click_on "Expenses"
    fill_in "expense[name]", with: "Internet"
    fill_in "expense[description]", with: "A Series of Tubes"
    fill_in "expense[amount]", with: "75"
    click_button "Create Expense"

    within('.balance') do
      expect(page).to have_content("-50.00")
    end

    click_on "Logout"
    login("other@test.com")
    within('.balance') do
      expect(page).to have_content("25.00")
    end

    click_on "Expenses"
    fill_in "expense[name]", with: "Heat"
    fill_in "expense[description]", with: "Hot hot"
    fill_in "expense[amount]", with: "30"
    click_button "Create Expense"

    within('.balance') do
      expect(page).to have_content("-5.00")
    end

    click_on "Logout"
    login("otherother@test.com")

    within('.balance') do
      expect(page).to have_content("35.00")
    end

    click_on "Logout"
    login
    click_on "Payments"

    within('.balance') do
      expect(page).to have_content("-40.00")
    end

    click_on "Logout"
    login("otherother@test.com")
    click_on "Payments"

    all(".pay-button").first.click

    within('.balance') do
      expect(page).to have_content("10.00")
    end
  end
end

