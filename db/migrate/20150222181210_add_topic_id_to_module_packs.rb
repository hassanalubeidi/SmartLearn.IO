class AddTopicIdToModulePacks < ActiveRecord::Migration
  def change
  	def change
	  add_column :module_packs, :topic_id, :integer
	end
  end
end