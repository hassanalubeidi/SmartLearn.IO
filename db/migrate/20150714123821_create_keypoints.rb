class CreateKeypoints < ActiveRecord::Migration
  def change
    create_table :keypoints do |t|

      t.timestamps
    end
  end
end
