class AddTextToFlashcards < ActiveRecord::Migration
  def change
  	add_column :flashcards, :text, :text
  end
end
