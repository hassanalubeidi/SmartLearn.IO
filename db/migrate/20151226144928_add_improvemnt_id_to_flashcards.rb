class AddImprovemntIdToFlashcards < ActiveRecord::Migration
  def change
    add_column :improvements, :flashcard_id, :integer
  end
end
