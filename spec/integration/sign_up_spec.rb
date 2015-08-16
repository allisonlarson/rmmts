require 'rails_helper'
RSpec.describe "User can sign-up", type: :feature do

  context "new user" do
    it "creates a user" do
      visit '/'
      click_on 'Get Started'
      expect(current_path).to eq(new_user_path)
      fill_in 'user[name]', with: "Test User"
      fill_in 'user[email]', with: "test@test.com"
      fill_in 'user[password]', with: "password"
      fill_in 'user[password_confirmation]', with: "password"
      click_button "Create User"

      expect(page).to have_content 'Welcome Test User'
    end
  end

  context "existing user" do
    before { User.create(name: "Existing User", email: "test@test.com", password: "password", password_confirmation: "password") }

    it "renders an error" do
      visit '/'
      click_on 'Get Started'
      expect(current_path).to eq(new_user_path)
      fill_in 'user[name]', with: "User"
      fill_in 'user[email]', with: "test@test.com"
      fill_in 'user[password]', with: "password"
      fill_in 'user[password_confirmation]', with: "password"
      click_button "Create User"

      expect(page).to_not have_content 'Welcome Test User'
    end
  end
end
