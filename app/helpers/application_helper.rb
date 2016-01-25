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
	def angular
		return """
		<script src='https://code.jquery.com/jquery-2.1.4.min.js'></script>
		<script src='http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js'></script>
		<script src='https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.5.0-rc.0/angular-resource.js'></script>
		<script src='https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.1.7/semantic.min.js'></script>
		<script src='https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.5.0-rc.0/angular-sanitize.js'></script>
		<script src='https://ajax.googleapis.com/ajax/libs/angularjs/X.Y.Z/angular-sanitize.js'></script>
		<link href='http://content.doublestruck.eu/style/ds.css' rel='stylesheet' type='text/css'>
		""".html_safe
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
	def current_url(new_params)
 url_for params.merge(new_params)
end
end
