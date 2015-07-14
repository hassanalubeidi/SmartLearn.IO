class AddFlashcardIdToObjectives < ActiveRecord::Migration
  def change
  	add_column :flashcards, :objective_id, :integer
  end
end
