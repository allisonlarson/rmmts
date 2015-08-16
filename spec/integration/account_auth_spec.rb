require 'rails_helper'
RSpec.describe "User can authorize account", type: :feature do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:venmo]
    User.create(name: "Test User", email: "test@test.com", password: "password", password_confirmation: "password")

    visit '/'
    click_on 'Login'
    fill_in 'email', with: "test@test.com"
    fill_in 'password', with: "password"
    click_button "Login"
  end

  it "creates an account" do
    click_on "Login with Venmo"
    expect(page).to have_content("venmo")
  end
end
