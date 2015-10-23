class CreateJoinTableFix < ActiveRecord::Migration
  def change
  	add_column :main_questions_objectives, :main_question_id, :integer
  end
end
