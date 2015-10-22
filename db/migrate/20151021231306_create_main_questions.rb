class CreateMainQuestions < ActiveRecord::Migration
  def change
    create_table :main_questions do |t|
      t.text :answer_html
      t.string :exampro_id

      t.timestamps
    end
  end
end
