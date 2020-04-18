class Admins::DashboardsController < Admins::ApplicationController
	def index
		@users = User.group_by_day(:created_at).count
		@books = Book.group(:category).count
		@reviews = Review.group_by_day(:created_at).count
	end
end
