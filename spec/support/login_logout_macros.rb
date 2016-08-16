module LoginLogoutMacros
  def login(email, password="password")
    visit root_url
    fill_in "login-email", with: email
    fill_in "login-pass", with: password
    click_button("Login")
  end

  def logout
    click_link "Sign Out"
  end
end