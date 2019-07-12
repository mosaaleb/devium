module Features
  def feature_sign_in(email, password)
    visit root_path
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_on "Login"
  end
end