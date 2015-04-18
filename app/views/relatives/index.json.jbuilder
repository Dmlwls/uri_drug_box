json.array!(@relatives) do |relative|
  json.extract! relative, :id, :email, :phone_number, :user_id, :name
  json.url relative_url(relative, format: :json)
end
