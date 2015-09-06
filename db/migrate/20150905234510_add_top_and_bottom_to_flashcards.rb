class AddTopAndBottomToFlashcards < ActiveRecord::Migration
  def change
  	add_column :flashcards, :top, :text
  	add_column :flashcards, :bottom, :text
  end
end
