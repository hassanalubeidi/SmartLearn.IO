class AddImportantToTestPapers < ActiveRecord::Migration
  def change
    add_column :test_papers, :test_papers, :string
    add_column :test_papers, :important, :boolean
  end
end
