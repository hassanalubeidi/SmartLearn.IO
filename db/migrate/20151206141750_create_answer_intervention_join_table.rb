class CreateAnswerInterventionJoinTable < ActiveRecord::Migration
  def change
  	create_join_table :interventions, :answers do |t|
	  t.integer :intervention_id
	  t.integer :answer_id
	end
  end
end

