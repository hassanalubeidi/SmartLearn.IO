class CreateArcticles < ActiveRecord::Migration
  def change
    create_table :arcticles do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
