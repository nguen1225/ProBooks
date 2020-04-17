class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :admin_user, only: %i[index]

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '更新しました'
    else
      render :edit
    end
  end

  def show
    @user_reviews_count = @user.reviews.count
    @user_craps_count = Clap.where(review_id: @user.reviews.ids).size
  end

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.csv  do
        send_data @users.generate_csv,
                  filename: "users-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"
      end
    end
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

  #管理者権限あり
  def admin_user
    unless current_user.admin == true
      redirect_to root_path, notice: "権限がありません"
    end
  end
end
