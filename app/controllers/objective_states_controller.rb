class ObjectiveStatesController < ApplicationController
	def new
		@objective = Objective.find(params[:objective_id])
    	@objective_state = ObjectiveState.new(:objective=>@objective)
    	session[:prev_url] = request.referer

	end
	def create
		@objective_state = ObjectiveState.new(objective_state_params)
	    @objective = Objective.find(params[:objective_id])
	    @objective_state.objective = @objective
	    @objective_state.user = current_user
	    @objective_state.save
	    if @objective_state.save then redirect_to session[:prev_url] end
	end

	private

	def objective_state_params
      params.require(:objective_state).permit(:objective_state_id, :user_id, :objective_id, :status)
    end
end
