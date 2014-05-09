class CreateLineDevices < ActiveRecord::Migration
  def change
    create_table :line_devices do |t|
      t.integer :line_id,
        :null => false

      t.integer :vehicle_device_id,
        :null => false

      t.timestamps
    end
  end
end
