require 'rails_helper'

feature 'user', type: :feature do
  given(:user) { build(:user) }
  given(:login_user) { create(:user) }
  it 'creates a new registered user', js: true do
    visit root_path
    click_on 'Get Started'
    click_on 'Sign up now'
    fill_in "Username", with: user.username
    fill_in "E-Mail", with: user.email
    fill_in "Password", with: user.password
    fill_in "Member", with: user.member
    fill_in "Profile", with: user.profile
    fill_in "Works", with: user.works
    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  it 'signs in with email and password', js: true do
    visit root_path
    click_on 'Get Started'
    fill_in 'Email address', with: login_user.email
    fill_in 'Password', with: login_user.password
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully.'
  end
  it 'posts a new prototype'
end
