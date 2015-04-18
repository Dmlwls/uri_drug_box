json.array!(@consumptions) do |consumption|
  json.extract! consumption, :id, :start_time, :take_status, :prow_id
  json.url consumption_url(consumption, format: :json)
end
