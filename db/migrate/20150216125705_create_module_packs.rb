class CreateModulePacks < ActiveRecord::Migration
  def change
    create_table :module_packs do |t|
      t.string :name
      t.references :unit, index: true

      t.timestamps
    end
  end
end
