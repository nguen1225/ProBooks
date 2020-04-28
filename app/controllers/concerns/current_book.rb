module CurrentBook
	extend ActiveSupport::Concern

	private
	def set_book_id
		@book = Book.find(params[:book_id])
	end
end