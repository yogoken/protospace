module ControllerMacros
  def login_user
    before(:each) do
      # users_controllerでauthenticate_user!を利用している際にsign_inしてもroot_pathにリダイレクトされてしまうため、それを防ぐ方法としてstubを追加する必要がある。要するに、処理の中でControllerの:authenticate_user!が呼び出されると、戻り値として指定してあるtrueが返されるようになる
      controller.stub(:authenticate_user!).and_return true
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user)
    end
  end
end
