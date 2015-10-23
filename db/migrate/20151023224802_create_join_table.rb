class CreateJoinTable < ActiveRecord::Migration
  def change
  	create_table :main_questions_objectives, id: false do |t|
      t.belongs_to :question, index: true
      t.belongs_to :objective, index: true
    end
  end
end
