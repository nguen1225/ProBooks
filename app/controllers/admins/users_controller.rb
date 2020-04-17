class Admins::UsersController < Admins::ApplicationController
	def index
		@users = User.all
		respond_to do |format|
		  format.html
		  format.csv  do
			send_data @users.generate_csv,
					  filename: "users-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"
		  end
		end
	end
end