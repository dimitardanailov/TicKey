class CreateVehicleDevices < ActiveRecord::Migration
  def change
    create_table :vehicle_devices do |t|
      t.string :unique_id,
        :null => false

      t.integer :major,
        :null => true,
        :default => nil

      t.integer :minor,
        :null => true,
        :default => nil

      t.timestamps
    end
  end
end
