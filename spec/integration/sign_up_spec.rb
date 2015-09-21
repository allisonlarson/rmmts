require 'rails_helper'
RSpec.describe "User can sign-up", type: :feature do

  context "new user" do
    it "creates a new society and user" do
      visit '/'
      fill_in 'society', with: "test"
      click_on 'Go'

      fill_in 'user[email]', with: "test@test.com"
      fill_in 'user[password]', with: "password"
      fill_in 'user[password_confirmation]', with: "password"
      click_on "Sign up"

      expect(current_path).to eq(new_society_path)

      fill_in 'society[name]', with: 'test'
      click_on "Create Society"

      expect(page).to have_content 'test@test.com'
    end
  end

  context "existing user" do

    context "without a society" do
      before { User.create(name: "Existing User", email: "test@test.com", password: "password", password_confirmation: "password") }
      it "pushes to create society" do
        visit '/'
        login
        expect(current_path).to eq(new_society_path)
      end

    end
    before do
      User.create(name: "Existing User", email: "test@test.com", password: "password", password_confirmation: "password")
    end

    it "renders an error" do
      visit '/'
      fill_in 'society', with: "test"
      click_on 'Go'

      fill_in 'user[email]', with: "test@test.com"
      fill_in 'user[password]', with: "password"
      fill_in 'user[password_confirmation]', with: "password"

      click_button "Sign up"

      expect(page).to_not have_content 'Test User'
    end
  end
end
