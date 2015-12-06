class CreateInterventions < ActiveRecord::Migration
  def change
    create_table :interventions do |t|
      t.text :problem
      t.text :fix

      t.timestamps
    end
  end
end
