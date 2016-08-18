require 'rails_helper'

feature "create new user"  do

  scenario "user is redirected to timeline when creating new account with valid data" do
    create_new_user
    expect(page).to have_content("Timeline")
  end

  scenario "user is redirected to root path when creating new account with invalid data" do
    create_new_user(password_conf: "mumblejumble")
    expect(page).to_not have_content("Timeline")

  end

  scenario "user is redirected to root path when creating new account with invalid data (email)" do
    create_new_user(email: "a")
    expect(page).to_not have_content("Timeline")

  end


end