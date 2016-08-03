class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_url, notice: "Updated profile successfully"
    else
      redirect_to edit_user_path, alert: 'All forms can\'t be blank'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(
        :username,
        :email,
        :password,
        :member,
        :profile,
        :works,
        :avatar
        )
    end
end
