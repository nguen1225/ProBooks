module ApplicationHelper
	#admin権限
	def admin_flag?(user)
		user.admin == true
	end

	#ユーザーの一致
	def match_user?(user)
		user == current_user
	end
end
