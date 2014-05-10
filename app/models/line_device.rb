class LineDevice < ActiveRecord::Base
  belongs_to :line
  belongs_to :vehicle_device
end
