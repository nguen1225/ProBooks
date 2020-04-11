class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  def edit
  end

  def update
   if @user.update(user_params)
      redirect_to user_path(@user), notice: "更新しました"
   else
      render :edit
   end
  end

  def show
  end

  def index
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:name,
                                 :introduction,
                                 :status,
                                 :image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
