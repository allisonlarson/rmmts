require 'rails_helper'
RSpec.describe "User can login", type: :feature do

  context "valid user" do
    before do
      society = Society.create(name: "Test")
      User.create(name: "Test User", email: "test@test.com", password: "password", password_confirmation: "password", society: society)
      visit '/'
    end

    context "homepage" do
      it "logs in with society" do
        fill_in 'society', with: "Test"
        click_on 'Go'

        fill_in 'user[email]', with: "test@test.com"
        fill_in 'user[password]', with: "password"
        click_button "Log in"

        expect(page).to have_content 'Test User'
      end
    end

    context "login page" do
      before do
        login
      end

      it "logs in" do
        expect(page).to have_content 'Test User'
      end

      it "logs out" do
        click_link "Logout"
        expect(page).to_not have_content 'Test User'
      end
    end
  end

  context "invalid user" do
    it "returns an error" do
      visit '/'
      click_on 'Login'
      fill_in 'user[email]', with: "Test User"
      fill_in 'user[password]', with: "Password"
      click_button "Log in"

      expect(page).to_not have_content 'Test User'
    end
  end
end
