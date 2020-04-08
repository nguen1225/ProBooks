class ReviewsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @review = Review.new(review_params)
    if @review.save
      redirect_to book_path(@book), notice: '投稿しました'
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @review = Review.find(params[:id])
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
end
