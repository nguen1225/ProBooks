class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit destroy update]

  def index
    @q = Book.ransack(params[:q])
    @books = if params[:tag]
               Book.tagged_with(params[:tag])
             elsif @q
               @q.result(distinct: true)
             else
               Book.all
             end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = '登録しました'
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def show
    @clap = Clap.new
    @review = Review.new
    @reviews = Review.where(book_id: params[:id])
  end

  def edit; end

  def update
    @book.update(book_params)
    redirect_to book_path(@book), notice: '更新しました'
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: '削除しました'
  end

  # def search
  #   @search_category = params[:option]
  #   if @search_category == 1
  #     @search_books = Book.where(book_id: 1)
  #   elsif @search_category == 2
  #     @search_books = Book.where(category: "php")
  #   elsif @search_category == 3
  #     @search_books = Book.where(category: "ruby")
  #   elsif @search_category == 4
  #     @search_books = Book.where(category: "javascript")
  #   end
  # end

  private

  def book_params
    params.require(:book).permit(:title,
                                 :content,
                                 :category,
                                 :user_id,
                                 :tag_list)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
