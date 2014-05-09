json.array!(@users) do |user|
  json.extract! user, :id, :email, :first_name, :last_name, :pin, :password, :picture
  json.url user_url(user, format: :json)
end
