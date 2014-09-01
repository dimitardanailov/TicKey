class VehicleDevice < ActiveRecord::Base

  has_one :line_device

  has_one :line, through: :line_device

  validates_presence_of :unique_id
  validates_uniqueness_of :unique_id, :allow_blank => false

end
