require 'rails_helper'

feature 'user', type: :feature do
  given(:user) { build(:user) }
  given(:login_user) { create(:user) }
  given(:prototype) {build(:prototype)}

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

  it 'posts a new prototype', js: true do
    visit root_path
    click_on 'Get Started'
    fill_in 'Email address', with: login_user.email
    fill_in 'Password', with: login_user.password
    click_on 'Sign in'
    click_on 'New Photo'
    fill_in 'Title', with: prototype.title
    4.times do |i|
      # attach_file(locator, path, options = {} )で今回の場合はoptionsはないので、どこに保存するのかと、どこどこにある何を保存するのかを記載している。
      attach_file 'prototype[prototype_images_attributes][#{i}][content]', File.join(Rails.root, '/spec/fixtures/img/test.png')
    end
    fill_in 'Catch Copy', with: prototype.catch_copy
    fill_in 'Concept', with: prototype.concept
    click_on 'Publish'
    expect(page).to have_content 'Saved prototype successfully'
  end
end
