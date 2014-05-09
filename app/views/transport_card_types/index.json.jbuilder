json.array!(@transport_card_types) do |transport_card_type|
  json.extract! transport_card_type, :id, :name
  json.url transport_card_type_url(transport_card_type, format: :json)
end
