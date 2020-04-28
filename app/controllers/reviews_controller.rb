class ReviewsController < ApplicationController
  include CurrentBook
  before_action :set_book_id, only: [:edit, :update, :create]
  before_action :load_resource

  def create
    if @review.save
      redirect_to book_path(@book), notice: '投稿しました'
      @book.save_notification_review!(current_user,
                                      @review.id,
                                      @book.user.id)
    else
      @clap = Clap.new
      @books = Book.where(category: params[:category])
      @reviews = Review.where(book_id: params[:id])
                       .page(params[:page])
      render template: 'books/show'
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      redirect_to book_path(@book), notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = '削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def review_params
    params.require(:review).permit(:title,
                                   :body,
                                   :rate,
                                   :user_id,
                                   :book_id)
  end

  def load_resource
    case params[:action].to_sym
    when :edit, :update, :destroy
      @review = Review.find(params[:id])
    when :create
      @review = Review.new(review_params)
    end
  end
end
