class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit destroy]

  def index
    if params[:tag]
      @books = Book.tagged_with(params[:tag])
    else
      @books = Book.all
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
    @review = Review.new
    @reviews = Review.where(params[:book_id])
  end

  def edit
  end

  def update
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: '削除しました'
  end

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
