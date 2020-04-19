class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '更新しました'
    else
      render :edit
    end
  end

  def show
    @user_reviews_count = Review.where(user_id: @user.id).size
    #拍手をもらった回数
    @user_craps_count = Clap.where(review_id: @user.reviews.ids).size
    @user_post_claps = Clap.where(user_id: @user.id).count
    @user_post_books = @user.books.size
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
