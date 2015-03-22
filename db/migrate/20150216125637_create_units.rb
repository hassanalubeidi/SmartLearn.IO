class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.references :subject, index: true

      t.timestamps
    end
  end
end
