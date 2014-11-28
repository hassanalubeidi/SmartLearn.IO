class AddSubjectIdToImprovements < ActiveRecord::Migration
  def change
  	add_column :improvements, :subject_id, :integer
  end
end
