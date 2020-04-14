class FavoritesController < ApplicationController

	def create
		@book = Book.find(params[:book_id])
		@favorite = current_user.favorites.create(favorite_params)
	end

	def destroy
		@book = Book.find(params[:id])
		@favorite = Favorite.find(params[:book_id])
		@favorite.destroy
	end

	private
	def favorite_params
		params.permit(:book_id)
	end
end
