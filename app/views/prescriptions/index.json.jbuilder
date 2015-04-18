json.array!(@prescriptions) do |prescription|
  json.extract! prescription, :id, :user_id, :doctor_name
  json.url prescription_url(prescription, format: :json)
end
