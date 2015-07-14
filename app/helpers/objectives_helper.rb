module ObjectivesHelper
	def dom_input_name(form, field_name)
	  "#{form.object_name}[#{field_name.to_s.sub(/\?$/,"")}]"
	end
end
