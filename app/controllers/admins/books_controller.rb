class Admins::BooksController < Admins::ApplicationController
	def index
		@books = Book.all
		respond_to do |format|
			format.html
			format.csv do
			  send_data @books.generate_csv,
						filename: "books-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"
			end
		end
	end
end