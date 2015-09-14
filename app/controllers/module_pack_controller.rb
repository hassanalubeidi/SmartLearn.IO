class ModulePackController < ApplicationController
	def index
		@subject = Subject.find(params[:subject_id])
	end
	def edit
	end
end
