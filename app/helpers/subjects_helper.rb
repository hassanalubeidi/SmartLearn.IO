module SubjectsHelper
	def marks(question)
		return "#{question.answers.where(:user => current_user).last.marks_integer}/#{question.total_marks}"
	end 
	def progress_in_topic(topic)
		marks = 0
		total_marks = 0
		get_questions_of_topic(topic).each do |question|
			unless question.answers.where(:user => current_user).blank?
				marks += question.answers.where(:user => current_user).last.marks_integer.to_i * time_degredation(question)
				total_marks += question.total_marks
			end
		end
		return (marks.to_f / total_marks.to_f) * 100
	end

	def progress_in_objective(objective)
		marks = 0
		total_marks = 0
		objective.questions.each do |question|
			unless question.answers.where(:user => current_user).count == 0 then
				marks += question.answers.where(:user => current_user).last.marks_integer.to_i * time_degredation(question)
				total_marks += question.total_marks
			end
		end
		return (marks.to_f / total_marks.to_f) * 100
	end

	def objective_traffic_light(objective)
		score = progress_in_objective(objective)
		nan = 0.0/0 # OR nan = Float::NAN
		nan.class
		nan.nan?
		nan.is_a?(Float) && nan.nan?
		(score.is_a?(Float) && score.nan?) ? 0 : score
		
		
		if score < 50 then
			return "red"
		elsif score < 69
		 return "yellow"
		elsif score > 70 
			return "green"
		else return ""
		end
	end

	def get_questions_of_topic(topic)
		questionss = []

		topic.objectives.first.questions.count
		topic.objectives.each do |objective|
			objective.questions.each do |question|
				questionss.push(question)
			end
		end

		questionss.uniq
	end	

	def get_good_objectives(topic)
		questions = get_questions_of_topic(topic)
		good_objectives = []
		topic.objectives.each do |objective|
			if progress_in_objective(objective) > 70 then 
				good_objectives.push(objective)
			end
		end
		good_objectives
	end

	def get_ok_objectives(topic)
		questions = get_questions_of_topic(topic)
		ok_objectives = []
		topic.objectives.each do |objective|
			if progress_in_objective(objective) > 45 and progress_in_objective(objective) < 70 then 
				ok_objectives.push(objective)
			end
		end
		ok_objectives
	end

	def get_bad_objectives(topic)
		questions = get_questions_of_topic(topic)
		bad_objectives = []
		topic.objectives.each do |objective|
			if progress_in_objective(objective) < 45 then 
				bad_objectives.push(objective)
			end
		end
		bad_objectives
	end

	def get_NaN_objectives(topic)
		questions = get_questions_of_topic(topic)
		nan = 0.0 / 0.0
		nan_objectives = []
		topic.objectives.each do |objective|
			if progress_in_objective(objective) < 101 then 
				
			else
				nan_objectives.push(objective)

			end
		end
		nan_objectives
	end

	def get_objective_state(objective)
		objective_status = objective.objective_states.where(:user => current_user).last.status unless objective.objective_states.where(:user => current_user).count == 0
		if objective_status == "full" then
			return "<i class='ui green checkmark icon popup-add' data-content='This objective is fully in memory' data-variation='inverted' data-position='right center'></i>".html_safe
		elsif objective_status == "not fluent" then
			return "<strong class='letter icon popup-add' data-content='Main points of objective in memory, but not fluent' data-variation='inverted' data-position='right center'>F</strong>".html_safe
		elsif objective_status == "partial" then
			return "<strong class='letter icon popup-add' data-content='Some parts are weakly learnt, some not learnt at all' data-variation='inverted' data-position='right center'>P</strong>".html_safe
		elsif objective_status == "none" then
			return "<i class='ui red remove icon popup-add' data-content='Welp, get to work I guess..' data-variation='inverted' data-position='right center'></i>".html_safe
		end
	end

	private
	def time_degredation(question)
		a = (Time.now -  question.answers.where(:user => current_user).last.created_at).to_i / 86400
		return half_life(question.created_at) ** -(a) # exponentail graph
	end
	def half_life(date)
		case date.strftime("%B")
		when "September", "October" , "November" , "December"
			return 1.02337 #30 day half life - learning process
		when "January" , "February"
			return 1.01748 #40 day half life - applying knowlege from previous terms
		when "March"
			return 1.01369 #50 day half life - almost finished learning, started revising
		when "April" , "May" , "June"
			return 1.02337 #70 day - completely finished learning, just revising
		end


	end

	
end
