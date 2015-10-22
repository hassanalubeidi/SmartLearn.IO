class Objectives < ActiveRecord::Migration
  def change
  	add_column :objectives, :main_question_id, :integer
  end
end
