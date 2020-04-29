class BooksController < ApplicationController
  include SetInstance
  before_action :all_categories, only: %i[index new edit]
  before_action :set_book, only: %i[show edit destroy update]
  before_action :authenticate_user!, only: %i[new edit]
  before_action :correct_user, only: %i[edit]

  def index
    @search_params = book_search_params
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
  end

  def update
    @book.update(book_params)
    redirect_to book_path(@book), notice: '更新しました'
  end

  def destroy
    @book.destroy
    flash[:notice] = '削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def book_params
    params.require(:book).permit(:title,
                                 :content,
                                 :volume,
                                 :level,
                                 :image,
                                 :category_id,
                                 :tag_list)
                          .merge(user_id: current_user.id)
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

  def correct_user
    unless current_user.id == @book.user_id
      redirect_to root_path
      flash[:alert] = '投稿者でないと編集できません'
    end
  end
end
