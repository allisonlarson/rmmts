require 'rails_helper'
RSpec.describe "User can sign-up", type: :feature do

  context "new user" do
    it "creates a new society and user" do
      visit '/'
      fill_in 'society', with: "test"
      click_on 'Go'
      expect(current_path).to eq(new_society_path)

      fill_in 'society[users_attributes][0][name]', with: "Test User"
      fill_in 'society[users_attributes][0][email]', with: "test@test.com"
      fill_in 'society[users_attributes][0][password]', with: "password"
      fill_in 'society[users_attributes][0][password_confirmation]', with: "password"
      fill_in 'society[name]', with: "Test Society"
      click_button "Create Society"

      expect(page).to have_content 'Test User'
    end
  end

  context "existing user" do
    before do
      User.create(name: "Existing User", email: "test@test.com", password: "password", password_confirmation: "password")
    end

    it "renders an error" do
      visit '/'
      fill_in 'society', with: "test"
      click_on 'Go'
      expect(current_path).to eq(new_society_path)

      fill_in 'society[users_attributes][0][name]', with: "User"
      fill_in 'society[users_attributes][0][email]', with: "test@test.com"
      fill_in 'society[users_attributes][0][password]', with: "password"
      fill_in 'society[users_attributes][0][password_confirmation]', with: "password"
      fill_in 'society[name]', with: "Test Society"

      click_button "Create Society"

      expect(page).to_not have_content 'Test User'
    end
  end
end
