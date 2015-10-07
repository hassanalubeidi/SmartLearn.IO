class AddInterventionsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :intervention, :text
  end
end
