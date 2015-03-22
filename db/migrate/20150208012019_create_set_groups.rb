class CreateSetGroups < ActiveRecord::Migration
  def change
    create_table :set_groups do |t|
      t.string :name
      t.integer :year
      t.references :subject, index: true

      t.timestamps
    end
  end
end
