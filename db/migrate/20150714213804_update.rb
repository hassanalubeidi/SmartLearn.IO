class Update < ActiveRecord::Migration
  def change
  	add_column :attempts, :keypoint_id, :integer
  end
end
