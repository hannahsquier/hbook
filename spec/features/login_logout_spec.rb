
feature "can login and logout" do
  let(:user) { create(:user) }

  scenario "redirected to current user timeline with with valid login info" do
    login(user.email)
    expect(page).to have_css("div.alert-success")
    expect(page).to have_content("Timeline")
    expect(page).to have_content(user.full_name)

  end


  scenario "redirected to root url when logging in with invalid info" do
    login(user.email, "notpassword")
    expect(page).to have_css("div.alert-danger")
    expect(page).to have_content("Connect with all your friends!
")

  end

  scenario "can log out if logged in" do
    login(user.email)
    logout
    expect(page).to have_css("div.alert-success")
    expect(page).to have_content("Connect with all your friends!
")

  end

  scenario "can't log out if logged out" do
    visit root_url
    expect(page).to_not have_content("Sign Out")
  end
end