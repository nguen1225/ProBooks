class Admins::BooksController < Admins::ApplicationController
  def index
    @categories = Category.all
    @search_params = book_search_params
    @books = if params[:search]
               Book.search(@search_params)
             else
               Book.all
         end
    if params[:export_csv]
      send_data @books.generate_csv,
                filename: "登録書籍一覧-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"
    else
      render :index
    end
  end

  private

  def book_search_params
    params.fetch(:search, {}).permit(:title,
                                     :category_id,
                                     :few,
                                     :volume)
  end
end
