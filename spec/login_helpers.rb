module LoginHelpers

  def login(email="test@test.com")
    click_on 'Login'
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: "password"
    click_button "Log in"
  end

  def sign_up(email="test@test.com")
    fill_in 'user[name]', with: "Test User"
    fill_in "user[email]", with: email
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_on "Sign up"
  end

  def create_society(name="test")
    fill_in "society[name]", with: name
    click_on "Create Society"
  end

end
