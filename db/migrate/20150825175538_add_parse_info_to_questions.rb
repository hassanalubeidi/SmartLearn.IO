class AddParseInfoToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :html, :string
  	add_column :questions, :mark_scheme_html, :string
  	add_column :questions, :exam_notes_html, :string
  	add_column :questions, :source, :string
  	add_column :questions, :description, :string
  	add_column :questions, :type, :string
  end
end