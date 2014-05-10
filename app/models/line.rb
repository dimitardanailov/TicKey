class Line < ActiveRecord::Base
  has_many :line_devices
  has_many :card_purches

  validates_presence_of :name
end
