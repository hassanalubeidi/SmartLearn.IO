class AddTestPaperIdToMainQuestions < ActiveRecord::Migration
  def change
    add_column :main_questions, :main_questions, :string
    add_column :main_questions, :test_paper_id, :integer
  end
end
