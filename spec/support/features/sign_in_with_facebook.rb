module Features
  def sign_in_with_facebook
    mock_auth_hash
    click_link "Sign in with Facebook"
  end
end