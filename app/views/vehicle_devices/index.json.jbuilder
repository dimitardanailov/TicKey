json.array!(@vehicle_devices) do |vehicle_device|
  json.extract! vehicle_device, :id, :unique_id, :major, :minor
  json.url vehicle_device_url(vehicle_device, format: :json)
end
