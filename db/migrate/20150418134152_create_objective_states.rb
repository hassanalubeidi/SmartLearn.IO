class CreateObjectiveStates < ActiveRecord::Migration
  def change
    create_table :objective_states do |t|
      t.string :status
      t.references :user, index: true
      t.references :objective, index: true

      t.timestamps
    end
  end
end
