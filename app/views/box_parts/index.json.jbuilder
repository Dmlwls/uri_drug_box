json.array!(@box_parts) do |box_part|
  json.extract! box_part, :id, :part_num, :prow_id
  json.url box_part_url(box_part, format: :json)
end
