module ApplicationHelper

	def login_user
		current_user || current_admin
	end

	#ユーザーの一致
	def match_user?(user)
		user == login_user
	end

end
