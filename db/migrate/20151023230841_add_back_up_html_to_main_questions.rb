class AddBackUpHtmlToMainQuestions < ActiveRecord::Migration
  def change
    add_column :main_questions, :html, :text
  end
end
