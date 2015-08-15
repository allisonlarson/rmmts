require 'rails_helper'
RSpec.describe "User can login", type: :feature do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:venmo]
  end

  context "new user" do
    it "creates a user" do
      visit '/'
      click_on 'Login'
      expect(page).to have_content 'Test User'
    end
  end

  context "existing user" do
    before { User.create!(name: "Existing User", uid: OmniAuth.config.mock_auth[:venmo][:uid]) }

    it "finds exisiting user" do
      visit '/'
      click_on 'Login'
      expect(page).to have_content 'Existing User'
      expect(page).to_not have_content 'Test User'
    end
  end
end
