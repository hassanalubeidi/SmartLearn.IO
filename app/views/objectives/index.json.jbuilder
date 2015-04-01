json.array!(@objectives) do |objective|
  json.extract! objective, :id, :name, :module_pack_info, :total_marks, :belongs_to
  json.url objective_url(objective, format: :json)
end
