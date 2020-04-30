class UsersController < ApplicationController
  before_action :load_resource

  def edit
    if current_user != @user
      flash[:notice] = '正しいユーザではありません'
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'アカウント情報を更新しました'
    else
      render :edit
    end
  end

  def show
      @user_reviews_count = Review.where(user_id: @user.id).size
      @user_craps_count = Clap.where(review_id: @user.reviews.ids).size
      @user_post_claps = Clap.where(user_id: @user.id).count
      @user_post_books = @user.books.size
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :introduction,
                                 :status,
                                 :image)
  end

  def load_resource
    case params[:action].to_sym
    when :edit, :update
      @user = User.find(params[:id])
    when :show
      @user = User.find(params[:id])
      @favorites = @user.favorites.all
                        .page(params[:page])
                        .per(3)
    end
  end
end
