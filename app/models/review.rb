class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :improvement
end
