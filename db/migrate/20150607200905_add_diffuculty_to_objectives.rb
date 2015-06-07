class AddDiffucultyToObjectives < ActiveRecord::Migration
  def change
  	add_column :objectives, :easier_difficulty, :integer
  	add_column :objectives, :harder_difficulty, :integer
  end
end
