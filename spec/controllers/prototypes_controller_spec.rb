require 'rails_helper'

describe PrototypesController do
  let!(:prototype) { create(:prototype) }
  let!(:params) {{
    id: prototype.id,
    prototype: attributes_for(:prototype, title: "sample")
  }}
  let!(:invalid_params) {{
    id: prototype.id,
    prototype: attributes_for(:prototype, title: nil)
  }}
  describe 'with user login' do
    login_user
    describe 'GET #index' do
      before do
        get :index
      end
      it 'assigns the requested prototypes to @prototypes' do
        expect(assigns(:prototypes)).to include prototype
      end
      it 'renders the :index template' do
        expect(response).to render_template :index
      end
    end

    describe 'GET #new' do
      before do
        get :new
      end
      it 'assigns the requested prototype to @prototype' do
        expect(assigns(:prototype)).to be_a_new(Prototype)
      end
      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        before do
          post :create, params
        end
        it "saves the new prototype in the database" do
          # そもそもchangeマッチャを利用する際にはブロックを渡さなければいけなくて、処理の前の値と後の値を取得し、前後での数の変化をテストできる
          expect{ post :create, params }.to change(Prototype, :count).by(1)
        end
        it "redirects to root_path" do
          expect(response).to redirect_to root_path
        end
        it "shows flash messages to show save the prototype successfully" do
          expect(flash[:notice]).to eq "Saved prototype successfully"
        end
      end

      context 'with invalid attributes' do
        before do
          post :create, invalid_params
        end
        it 'does not save the new prototype in the database' do
          expect{ post :create, invalid_params }.not_to change(Prototype, :count)
        end
        it 'renders the :new template when a prototype does not save' do
          expect(response).to redirect_to new_prototype_path
        end
        it 'shows flash messages to show save the prototype unsuccessfully' do
          expect(flash[:alert]).to eq "Sorry, but something went wrong"
        end
      end
    end

    describe 'GET #show' do
      before do
        get :show, id: prototype.id
      end
      it 'assigns the requested prototype to @prototype' do
        expect(assigns(:prototype)).to eq prototype
      end
      it 'assigns the requested comment @comment' do
        expect(assigns(:comment)).to be_a_new(Comment)
      end
      it 'assigns likes associated with prototype to @likes' do
        expect(assigns(:like)).to eq prototype.likes
      end
      it 'renders the :show template' do
        expect(response).to render_template :show
      end
    end

    describe 'GET #edit' do
      before do
        get :edit, id: prototype.id
      end
      it 'assigns the requested prototype to @prototype' do
        expect(assigns(:prototype)).to eq prototype
      end
      it 'assigns main_image to @main_image' do
        expect(assigns(:main_content)).to eq(prototype.prototype_images.main)
      end
      it 'assigns sub_images to @sub_images' do
        expect(assigns(:sub_contents)).to eq(prototype.prototype_images.sub)
      end
      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      before do
        patch :update, params
      end
      context 'with valid attributes' do
        it 'assigns the requested prototype to @prototype' do
          expect(assigns(:prototype)).to eq prototype
        end
        it 'updates attributes of prototype' do
          prototype.reload
          expect(prototype.title).to eq "sample"
        end
        it 'redirects to root_path' do
          expect(response).to redirect_to root_path
        end
        it 'shows flash message of updating' do
          expect(flash[:notice]).to eq 'Updated prototype successfully'
        end
      end

      context 'with invalid attributes' do
        before do
          patch :update, invalid_params
        end
        it 'assigns the requested prototype to @prototype' do
          expect(assigns(:prototype)).to eq prototype
        end
        it 'does not save the new prototype' do
          expect(prototype.title).not_to eq 'sample'
        end
        it 'renders the :edit template' do
          expect(response).to redirect_to edit_prototype_path
        end
        it 'show flash message to show update prototype unsuccessfully' do
          expect(flash[:alert]).to eq "All forms can't be blank"
        end

      end
    end

    describe 'DETELE #destroy' do
      before do
        delete :destroy, id: prototype.id
      end
      it 'assigns the requested prototype to @prototype' do
        expect(assigns(:prototype)).to eq prototype
      end
      it 'deletes the prototype' do
        prototype = create(:prototype)
        expect{ delete :destroy, id: prototype.id }.to change(Prototype, :count).by(-1)
      end
      it 'redirects to root_path' do
        expect(response).to redirect_to root_path
      end
      it 'shows flash message to show delete prototype successfully' do
        expect(flash[:notice]).to eq "Deleted prototype successfully"
      end
    end
  end

  describe 'without user login' do
    describe 'GET #new' do
      it 'redirects sign_in page' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end
    describe 'post #create' do
      it 'redirects sign_in page' do
        get :create
        expect(response).to redirect_to new_user_session_path
      end
    end
    describe 'GET #edit' do
      it 'redirects sign_in page' do
        get :edit, id: prototype.id
        expect(response).to redirect_to new_user_session_path
      end
    end
    describe 'PATCH #update' do
      it 'redirects sign_in page' do
        patch :update, id: prototype.id
        expect(response).to redirect_to new_user_session_path
      end
    end
    describe 'DELETE #destroy' do
      it 'redirects sign_in page' do
        delete :destroy, id: prototype.id
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
