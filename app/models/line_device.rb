class LineDevice < ActiveRecord::Base
  belongs_to :line
  belongs_to :vehicle_device

  validates_presence_of :line_id
  validates_presence_of :vehicle_device_id
end
