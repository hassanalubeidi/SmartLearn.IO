class AddDiffucultyToObjectives < ActiveRecord::Migration
  def change
  	add_column :objectives, :easier_diffuclty, :integer
  	add_column :objectives, :harder_diffuclty, :integer
  end
end
