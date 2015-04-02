class CreateTestPapers < ActiveRecord::Migration
  def change
    create_table :test_papers do |t|
      t.belongs_to :subject, index: true
      t.date :date
      t.boolean :calc_allowed

      t.timestamps
    end
  end
end
