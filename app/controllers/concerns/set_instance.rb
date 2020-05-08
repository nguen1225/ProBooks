module SetInstance
  extend ActiveSupport::Concern

  private

  def set_book_id
    @book = Book.find(params[:book_id])
  end

  def all_categories
    @categories = Category.all
  end

  def set_review
    @review = Review.find(params[:review_id])
  end
end
