class AddNamesToTestPapers < ActiveRecord::Migration
  def change
  	add_column :test_papers, :name, :string
  end
end
