require 'features_helper'

feature "Session management" do

  scenario "failed sign in" do
    user = build(:user, login: 'unsaved_user')
    sign_in(user)
    expect(page).to have_content 'Nieprawidłowy login lub hasło.'  
  end                             

  scenario "successful sign in" do
    user = create(:user, login: 'admin')
    sign_in(user)
    expect(page).to have_content 'Logowanie zakończone powodzeniem.'   
  end                             

  scenario "sign out", js: true do
    user = create(:user, login: 'admin')
    sign_in(user)
    click_link('Wyloguj')
    expect(page).to have_content 'Wylogowanie zakończone powodzeniem.' 
  end

end
