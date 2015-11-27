module ApplicationHelper
	def show_if_teacher(user)
		# if user.power == "teacher" or user.power "admin" then
		# 	return yield
		# else
		# 	return nil
		# end
		if user.power == "admin" then
			return yield
		else
			return nil
		end
	end
	def colour(integer)
		integer = integer.to_i
		if integer > 90 then
			return "green"
		elsif integer > 75 then
			return "olive"
		elsif integer > 50 then 
			return "yellow"
		elsif integer > 30 then
			return "orange"
		else 
			return "red"
		end
	end
end
