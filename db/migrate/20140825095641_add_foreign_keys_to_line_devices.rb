class AddForeignKeysToLineDevices < ActiveRecord::Migration
  change_table :line_devices do |t|
    t.foreign_key :lines, dependent: :delete

    t.foreign_key :vehicle_devices, dependent: :delete
  end
end