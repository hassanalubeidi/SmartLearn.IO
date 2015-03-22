class RemoveTopicFromImprovements < ActiveRecord::Migration
  def change
  	remove_column :improvements, :topic
  	add_column :improvements, :topic_id, :references
  end
end
