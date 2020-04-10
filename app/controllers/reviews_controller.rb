class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :sett_book,  only: [:edit, :update, :create]
  def create
    @book = Book.find(params[:book_id])
    @review = Review.new(review_params)
    if @review.save
      redirect_to book_path(@book), notice: '投稿しました'
    else
      @clap = Clap.new
      @review = Review.new(review_params)
      @reviews = Review.where(params[:book_id])
      render template: 'books/show'
    end
  end

  def edit
    @book = Book.find(params[:book_id])
  end

  def update
    @book = Book.find(params[:book_id])
    if @review.update(review_params)
      redirect_to book_path(@book), notice: "更新しました"
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

  def set_review
    @review = Review.find(params[:id])
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
