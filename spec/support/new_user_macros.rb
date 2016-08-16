module NewUserMacros
  DEFAULT = {
   email: Faker::Internet.email,
   first_name: Faker:: Name.first_name,
   last_name: Faker:: Name.last_name,
   password: "password",
   password_conf: "password",
   birthday: Faker::Date.between(100.years.ago, 10.years.ago),
   gender: ["other", "female", "male"].sample
  }

  def create_new_user(options={})
    options = DEFAULT.merge(options)

    visit root_path
    fill_in('First Name', with: options[:first_name])
    fill_in('Last Name', with: options[:last_name])
    fill_in('InputEmail', with: options[:email])
    fill_in('InputPassword', with: options[:password])
    fill_in('ConfirmPassword', with: options[:password_conf])
    fill_in('dob', with: options[:birthday])
    choose("user_gender_" + options[:gender])

    click_button('Create Account')

  end
end