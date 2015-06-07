class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.date :date
      t.references :subject, index: true
      t.string :title
      t.text :powerpoint

      t.timestamps
    end
  end
end
