json.array!(@prows) do |prow|
  json.extract! prow, :id, :prescription_id, :drug_name, :period
  json.url prow_url(prow, format: :json)
end
