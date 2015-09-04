require 'rails_helper'
RSpec.describe "User can authorize account", type: :feature do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:venmo]
    society = Society.create(name: "test")
    User.create(name: "Test User", email: "test@test.com", password: "password", password_confirmation: "password", society: society)

    visit '/'
    click_on 'Login'
    fill_in 'email', with: "test@test.com"
    fill_in 'password', with: "password"
    click_button "Login"
    click_on "Link Venmo Account"
  end

  it "creates an account" do
    expect(page).to have_content("Name")
  end

  it "deletes an account" do
    click_on "Unlink"
    expect(page).to_not have_content("Name")
  end
end
