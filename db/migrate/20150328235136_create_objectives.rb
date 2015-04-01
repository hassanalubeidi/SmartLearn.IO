class CreateObjectives < ActiveRecord::Migration
  def change
    create_table :objectives do |t|
      t.text :name
      t.text :module_pack_info
      t.integer :total_marks
      t.belongs_to :question

      t.timestamps
    end
  end
end
