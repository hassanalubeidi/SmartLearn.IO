class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.belongs_to :question, index: true
      t.belongs_to :objective, index: true

      t.timestamps
    end
  end
end
