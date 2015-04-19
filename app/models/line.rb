class Line < ActiveRecord::Base
  belongs_to :question, :dependent => :destroy
  belongs_to :objective, :dependent => :destroy
end
