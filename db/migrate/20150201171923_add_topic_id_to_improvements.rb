class AddTopicIdToImprovements < ActiveRecord::Migration
  def change
    add_column :improvements, :topic_id, :integer
  end
end
