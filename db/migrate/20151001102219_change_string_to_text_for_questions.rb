class ChangeStringToTextForQuestions < ActiveRecord::Migration
  def change
  	change_column :questions, :html,  :text
  	change_column :questions, :mark_scheme_html,  :text
  	change_column :questions, :source,  :text
  	change_column :questions, :description,  :text
  	change_column :questions, :type,  :text
  end
end