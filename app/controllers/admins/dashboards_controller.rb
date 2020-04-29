class Admins::DashboardsController < Admins::ApplicationController
  def index
    @users = User.group_by_day(:created_at).size
    @categories = Category.joins(:books).group(:name).size
    @reviews = Review.group_by_day(:created_at).size
    @all_books = Book.all.size
    @all_users = User.all.size
    @all_reviews = Review.all.size
  end
end
