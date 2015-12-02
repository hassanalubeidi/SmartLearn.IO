class TestPaperReportController < ApplicationController
	def current_user_report
		@test_paper = TestPaper.find(params[:test_paper_id])
	end
	def specific_user_report
		@test_paper = TestPaper.find(params[:test_paper_id])
		@user = User.find(params[:id])
	end
end
