class AddFlashcardIdToKeypoints < ActiveRecord::Migration
  def change
  	add_column :keypoints, :flashcard_id, :integer
  end
end
