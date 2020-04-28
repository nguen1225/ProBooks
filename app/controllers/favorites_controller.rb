class FavoritesController < ApplicationController
  include CurrentBook
  before_action :set_book_id
  def create
    # @book = Book.find(params[:book_id])
    @favorite = current_user.favorites.create(favorite_params)
  end

  def destroy
    # @book = Book.find(params[:book_id])
    @favorite = current_user.favorites.find_by(favorite_params)
    @favorite.destroy
  end

  private

  def favorite_params
    params.permit(:book_id)
  end
end
