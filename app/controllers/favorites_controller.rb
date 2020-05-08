class FavoritesController < ApplicationController
  include SetInstance
  before_action :set_book_id
  def create
    @favorite = current_user.favorites.create(favorite_params)
  end

  def destroy
    @favorite = current_user.favorites.find_by(favorite_params)
    @favorite.destroy
  end

  private

  def favorite_params
    params.permit(:book_id)
  end
end
