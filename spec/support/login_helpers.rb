module LoginHelpers
  def login_as(role)
    @user = create(role)

    login_with(@user)
  end

  def login_with(user)
    visit new_user_session_path

    fill_in 'user[username]', with: user.username

    fill_in 'user[password]', with: '0123456789'

    click_button 'Sign In'

    Thread.current[:current_user] = user
  end

  def logout
    click_link 'Logout' rescue nil
  end
end
