class AddAttachmentPictureToAnswers < ActiveRecord::Migration
  def self.up
    change_table :answers do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :answers, :picture
  end
end
