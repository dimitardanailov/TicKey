json.array!(@line_devices) do |line_device|
  json.extract! line_device, :id, :line_id, :vehicle_device_id
  json.url line_device_url(line_device, format: :json)
end
