class AddBelongsToToAttemptedQuestions < ActiveRecord::Migration
  def change
    add_column :attempted_questions, :user_id, :integer
    add_column :attempted_questions, :answer_id, :integer
    add_column :attempted_questions, :question_id, :integer
    add_column :attempted_questions, :objective_id, :integer
    add_column :attempted_questions, :topic_id, :integer
    add_column :attempted_questions, :subject_id, :integer
  end
end
