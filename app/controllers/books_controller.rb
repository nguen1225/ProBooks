class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit destroy update]
  before_action :authenticate_user!, only: %i[new edit]

  def index
    @search_params = book_search_params
    @categories = Category.all
    @tags = Book.tag_counts_on(:tags).order('count  DESC')
    @books = if params[:tag]
               Book.tagged_with(params[:tag]).page(params[:page])
             elsif params[:search]
               Book.search(@search_params).page(params[:page])
             else
               Book.all.page(params[:page])
             end
  end

  def new
    @book = Book.new
    @books = Book.all
    @categories = Category.all
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book), notice: '登録しました'
    else
      @categories = Category.all
      render :new
    end
  end

  def show
    @clap = Clap.new
    @review = Review.new
    @reviews = Review.where(book_id: params[:id])
                     .page(params[:page])
                     .order(created_at: :desc)
  end

  def edit
    @categories = Category.all
  end

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
                                 :volume,
                                 :level,
                                 :image,
                                 :user_id,
                                 :category_id,
                                 :tag_list)
  end

  def book_search_params
    params.fetch(:search, {}).permit(:title,
                                     :category_id,
                                     :level,
                                     :volume)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
