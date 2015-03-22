class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :topic, index: true
      t.text :text
      t.integer :total_marks

      t.timestamps
    end
  end
end
