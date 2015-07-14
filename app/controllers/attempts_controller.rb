class AttemptsController < ApplicationController
	def new
		@attempt = Attempt.new
		respond_to do |format|
	      format.html # new.html.erb
	      format.json { render json: @attempt }
	      format.js
	    end
	end
	def create
	  @attempt = Attempt.new(attempt_params)

	  respond_to do |format|
	    if @attempt.save
	      format.html { redirect_to @attempt, notice: 'attempt was successfully created.' }
	      format.json { render json: @attempt, status: :created, location: @attempt }
	      format.js
	    else
	      format.html { render action: "new" }
	      format.json { render json: @attempt.errors, status: :unprocessable_entity }
	      format.js
	    end
	  end
	end
	private
	def attempt_params
      params[:attempt].permit(:id, :correct, :user_id)
    end
end
