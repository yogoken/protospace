require 'rails_helper'

describe UsersController do
  describe 'with user login' do
    describe 'GET #show' do
      it 'assigns the requested user to @user'
      it 'renders the :show templates'
    end
    describe 'GET #edit' do
      it 'assigns the requested user to @user'
      it 'renders the :edit template'
    end
    describe 'PATCH #update' do
      context 'with valid attributes' do
        it 'locates the requested @user'
        it "changes @user's attributes"
        it 'redirects to root_path'
        it 'sends flash messages'
      end
      context 'with invalid attributes' do
        it 'locates the requested @user'
        it "changes @user's attributes"
        it 'redirects to edit_user_path'
        it 'sends flash messages'
      end
    end
  end

  describe 'without user login' do
    describe 'GET #edit' do
      it 'redirects sign_in page'
    end
    describe 'PATCH #update' do
      it 'redirects sign_in page'
    end
  end
end
