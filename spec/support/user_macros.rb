module UserMacros

  def sign_in_as role
    @user = FactoryGirl.create(:user, :role => role)
    visit new_user_session_path
    fill_in "user_email", :with => @user.email
    fill_in "user_password", :with => @user.password
    click_button "Sign in"
    page.should have_content("Signed in successfully.")
  end

end