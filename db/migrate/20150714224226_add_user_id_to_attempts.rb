class AddUserIdToAttempts < ActiveRecord::Migration
  def change
  	add_column :attempts, :user_id, :integer
  end
end
