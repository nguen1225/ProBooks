class ClapsController < ApplicationController
	def create
		@clap = current_user.claps.create(clap_params)
		redirect_back(fallback_location: root_path)
	end

	def destroy
		@clap = current_user.claps.find_by(clap_params)
		@clap.destroy
		redirect_back(fallback_location: root_path)
	end

	private
	def clap_params
		params.permit(:review_id)
	end
end
