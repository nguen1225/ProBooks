class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit destroy update]

  def index
    @search_params = book_search_params
    @tags = Book.tag_counts_on(:tags).order('count  DESC')
    @books = if params[:tag]
               Book.tagged_with(params[:tag])
             elsif params[:search]
               Book.search(@search_params).includes(:user)
             elsif params[:change]
               Book.order(params[:change]).includes(:reviws)
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
    @books = Book.where(category: params[:category])
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

  private

  def book_params
    params.require(:book).permit(:title,
                                 :content,
                                 :category,
                                 :volume,
                                 :level,
                                 :image,
                                 :user_id,
                                 :tag_list)
  end

  def book_search_params
    params.fetch(:search, {}).permit(:title,
                                     :category,
                                     :user_id)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
