module ApplicationHelper
	def show_if_teacher(user)
		# if user.power == "teacher" or user.power "admin" then
		# 	return yield
		# else
		# 	return nil
		# end
		if user.power == "teacher" || "admin" then
			return yield
		else
			return nil
		end
	end
end
