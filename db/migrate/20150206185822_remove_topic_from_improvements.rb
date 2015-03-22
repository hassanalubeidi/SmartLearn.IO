class RemoveTopicFromImprovements < ActiveRecord::Migration
  def change
  	remove_column :improvements, :topic
  end
end
