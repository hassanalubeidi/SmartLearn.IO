class ModulePack < ActiveRecord::Base
  belongs_to :unit
  has_many :topics
end
