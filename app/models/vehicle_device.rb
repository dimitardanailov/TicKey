class VehicleDevice < ActiveRecord::Base

  has_many :line_devices

  validates_presence_of :unique_id
  validates_uniqueness_of :unique_id, :allow_blank => false
end
