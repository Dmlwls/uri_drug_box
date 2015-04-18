json.array!(@drugs) do |drug|
  json.extract! drug, :id, :name, :description, :prow_id
  json.url drug_url(drug, format: :json)
end
