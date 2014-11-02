class CreateImprovements < ActiveRecord::Migration
  def change
    create_table :improvements do |t|
      t.string :topic
      t.text :area_to_improve
      t.boolean :checked
      t.references :user, index: true

      t.timestamps
    end
  end
end
