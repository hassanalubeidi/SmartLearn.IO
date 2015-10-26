class CreateAttemptedQuestions < ActiveRecord::Migration
  def change
    create_table :attempted_questions do |t|

      t.timestamps
    end
  end
end
