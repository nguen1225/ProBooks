class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "登録しました"
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def edit
  end

  def show
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
                                 :user_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
