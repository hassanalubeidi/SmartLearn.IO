class AddTestPaperQuestionsJoinTable < ActiveRecord::Migration
  def change
  	create_table :main_questions_test_papers, id: false do |t|
      t.belongs_to :main_question, index: true
      t.belongs_to :test_paper, index: true
    end
  end
end


