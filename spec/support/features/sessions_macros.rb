module SessionsMacros
  def sign_in(user)
    visit root_path
    fill_in 'Login', with: user.login
    fill_in 'Hasło', with: 'Secret123' 
    click_button 'Zaloguj'
  end
end
