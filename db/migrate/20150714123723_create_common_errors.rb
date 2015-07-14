class CreateCommonErrors < ActiveRecord::Migration
  def change
    create_table :common_errors do |t|

      t.timestamps
    end
  end
end
