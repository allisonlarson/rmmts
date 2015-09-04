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

        fill_in 'email', with: "test@test.com"
        fill_in 'password', with: "password"
        click_button "Login"

        expect(page).to have_content 'Test User'
      end
    end

    context "login page" do
      before do
        click_on 'Login'
        fill_in 'email', with: "test@test.com"
        fill_in 'password', with: "password"
        click_button "Login"
      end

      it "logs in" do
        expect(page).to have_content 'Test User'
      end

      it "logs out" do
        click_link "Logout"
        expect(page).to_not have_content 'Test User'
      end

      it "deletes user account" do
        click_link "Delete Account"
        expect(page).to_not have_content 'Test User'
      end
    end
  end

  context "invalid user" do
    it "returns an error" do
      visit '/'
      click_on 'Login'
      fill_in 'email', with: "Test User"
      fill_in 'password', with: "Password"
      click_button "Login"

      expect(page).to_not have_content 'Test User'
    end
  end
end
