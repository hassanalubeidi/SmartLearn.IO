class GetRidOfTextLimitsInQuestions < ActiveRecord::Migration
  def change
  	change_column :questions, :html,  :text, :limit => nil
  	change_column :questions, :mark_scheme_html,  :text, :limit => nil
  	change_column :questions, :source,  :text, :limit => nil
  	change_column :questions, :description,  :text, :limit => nil
  	change_column :questions, :type,  :text, :limit => nil
  end
end
