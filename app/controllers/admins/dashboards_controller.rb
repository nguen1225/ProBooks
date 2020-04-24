class Admins::DashboardsController < Admins::ApplicationController
  def index
    @users = User.group_by_day(:created_at).count
    @categories= Category.joins(:books).group(:name).count
    @reviews = Review.group_by_day(:created_at).count
  end
end
