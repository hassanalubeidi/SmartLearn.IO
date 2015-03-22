json.array!(@set_groups) do |set_group|
  json.extract! set_group, :id, :name, :year, :subject_id
  json.url set_group_url(set_group, format: :json)
end
