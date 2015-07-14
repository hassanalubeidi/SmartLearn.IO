class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.boolean :correct

      t.timestamps
    end
  end
end
