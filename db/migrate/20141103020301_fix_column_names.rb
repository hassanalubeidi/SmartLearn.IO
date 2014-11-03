class FixColumnNames < ActiveRecord::Migration
  def change
  	change_table :users do |t|
      t.rename :type, :power
     end
  end
end
