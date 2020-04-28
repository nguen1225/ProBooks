class UsersController < ApplicationController
  before_action :load_resource

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'アカウント情報を更新しました'
    else
      render :edit
    end
  end

  def show
    # レビューをした回数
    @user_reviews_count = Review.where(user_id: @user.id).size
    # 拍手をもらった回数
    @user_craps_count = Clap.where(review_id: @user.reviews.ids).size
    # 拍手を送った回数
    @user_post_claps = Clap.where(user_id: @user.id).count
    # 書籍の投稿数
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
    when :edit
      @user = User.find(params[:id])
      if current_user != @user
        flash[:notice] = '正しいユーザではありません'
        redirect_back(fallback_location: root_path)
      end
    when :update, :show
      @user = User.find(params[:id])
    end
  end
end
