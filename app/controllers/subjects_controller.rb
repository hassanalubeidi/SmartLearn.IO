class SubjectsController < ApplicationController
	before_action :set_subject, only: [:show]
	def index
		redirect_to root_path
	end
	def show

	end
	private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def review_params
    #   params.require(:review).permit(:user_id, :improvement_id)
    # end
end
