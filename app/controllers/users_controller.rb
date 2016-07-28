class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: :update

  def show
  end

  def edit
  end

  def update
    if @user.id == current_user.id
      @user.update(user_params)
      redirect_to :root
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:username, :email, :password, :member, :profile, :works)
    end
end
