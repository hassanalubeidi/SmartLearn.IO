class AddTopicIdToObjectives < ActiveRecord::Migration
  def change
  	add_column :objectives, :topic_id, :integer
  end
end
