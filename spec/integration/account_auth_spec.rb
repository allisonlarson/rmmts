require 'rails_helper'
RSpec.describe "User can authorize account", type: :feature do
  before(:each) do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:venmo]
    visit '/'
    click_on "Go"

    sign_up
    create_society

    click_on "Link Venmo Account"
  end

  it "creates an account" do
    within('.payment-account-table') do
      expect(page).to have_content("venmo")
      expect(page).to have_content("test-user")
    end
    expect(page).to_not have_content('Link Venmo Account')
  end

  it "deletes an account" do
    click_on "Unlink"
    expect(page).to_not have_content("venmo")
    expect(page).to_not have_content("test-user")
    expect(page).to have_content('Link Venmo Account')
  end
end
