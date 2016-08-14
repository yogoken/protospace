require 'rails_helper'

describe UsersController do
  let!(:user){ create(:user) }
  # let(:params){{id: user.id, user:... }}のように記述すると{...}の値がparamsとして参照できる。その際に外側の{}はRubyのブロック、内側の{}はハッシュリテラルである
  let!(:params) {{
    id: user.id,
    user: attributes_for(:user, username: 'sample')
    }}
    # attributes_forはオブジェクトとして生成せずにハッシュを生成する、よって例として、=> { user_name: 'sample', email: ''...}のようになる
  let!(:invalid_params) {{
    id: user.id,
    user: attributes_for(:user, username: nil)
    }}
  describe 'with user login' do
    login_user
    describe 'GET #show' do
      before do
        get :show, id: user
      end
      it 'assigns the requested user to @user' do
        # コントローラーのインスタンス変数に代入されたオブジェクトを参照するため
        expect(assigns(:user)).to eq user
      end
      it 'renders the :show templates' do
        expect(response).to render_template :show
      end
    end
    describe 'GET #edit' do
      before do
        get :edit, id: user
      end
      it 'assigns the requested user to @user' do
        expect(assigns(:user)).to eq user
      end
      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end
    describe 'PATCH #update' do
      context 'with valid attributes' do
        before do
          patch :update, params
        end
        it 'locates the requested @user' do
          expect(assigns(:user)).to eq user
        end
        it "changes @user's attributes" do
          user.reload
          expect(user.username).to eq("sample")
        end
        it 'redirects to root_path' do
          expect(response).to redirect_to root_path
        end
        it 'sends flash messages' do
          expect(flash[:notice]).to eq 'Updated profile successfully'
        end
      end
      context 'with invalid attributes' do
        before do
          patch :update, invalid_params
        end
        it 'locates the requested @user' do
          expect(assigns(:user)).to eq user
        end
        it "changes @user's attributes" do
          user.reload
          expect(user.username).not_to eq("sample")
        end
        it 'redirects to edit_user_path' do
          expect(response).to redirect_to edit_user_path
        end
        it 'sends flash messages' do
          expect(flash[:alert]).to eq "All forms can't be blank"
        end
      end
    end
  end

  describe 'without user login' do
    describe 'GET #edit' do
      it 'redirects sign_in page' do
        get :edit, id: user
        expect(response).to redirect_to new_user_session_path
      end
    end
    describe 'PATCH #update' do
      it 'redirects sign_in page' do
        patch :update, params
        user.reload
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
