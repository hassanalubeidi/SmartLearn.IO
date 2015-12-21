class AddAttachmentPictureToFlashcards < ActiveRecord::Migration
  def self.up
    change_table :flashcards do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :flashcards, :picture
  end
end
