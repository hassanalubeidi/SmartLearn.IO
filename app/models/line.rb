class Line < ActiveRecord::Base
  belongs_to :question
  belongs_to :objective
end
