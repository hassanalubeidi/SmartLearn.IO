class FixExamNotes < ActiveRecord::Migration
  def change
  	change_column :questions, :exam_notes_html,  :text, :limit => nil
  end
end
