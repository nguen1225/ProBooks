class Admins::BooksController < Admins::ApplicationController
  include SetInstance
  before_action :all_categories, only: %i[index]
  def index
    @search_params = book_search_params
    @books = if params[:search]
               Book.search(@search_params)
                   .page(params[:page])
             else
               Book.all.page(params[:page])
             end
    if params[:export_csv]
      send_data @books.generate_csv,
                filename: "登録書籍一覧-#{Time.zone.now.strftime('%Y%m%d')}.csv"
    else
      render :index
    end
  end

  def import
    Book.import(params[:file])
    redirect_to admins_books_path, notice: '書籍を追加しました'
  end

  private

  def book_search_params
    params.fetch(:search, {}).permit(:title,
                                     :category_id,
                                     :few,
                                     :volume)
  end
end
