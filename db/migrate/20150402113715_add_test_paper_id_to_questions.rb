class AddTestPaperIdToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :test_paper_id, :integer
  end
end
