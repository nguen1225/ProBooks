class ClapsController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @book = Book.find(params[:book_id])
    @clap = current_user.claps.create(clap_params)
    @review.create_notification_clap!(current_user)
  end

  def destroy
    @review = Review.find(params[:review_id])
    @book = Book.find(params[:book_id])
    @clap = current_user.claps.find_by(clap_params)
    @clap.destroy
  end

  private

  def clap_params
    params.permit(:review_id)
  end
end
