json.array!(@card_purches) do |card_purch|
  json.extract! card_purch, :id, :user_id, :transport_card_type_id, :line_id, :expire_date
  json.url card_purch_url(card_purch, format: :json)
end
