class AddTextToKeypoints < ActiveRecord::Migration
  def change
  	add_column :keypoints, :text, :text
  end
end
