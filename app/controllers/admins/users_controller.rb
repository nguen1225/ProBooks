class Admins::UsersController < Admins::ApplicationController
	def index
		@search_params = user_search_params
		@users = if params[:search]
					User.with_deleted.search(@search_params)
				 else
					User.with_deleted
				 end
		if  params[:export_csv]
				send_data @users.generate_csv,
						filename: "users-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"
		else
			render :index
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to admins_users_path
	end

	private

	def user_search_params
		params.fetch(:search, {}).permit(:name,
										 :status,
										 :created_at_from,
										 :created_at_to)
	end
end