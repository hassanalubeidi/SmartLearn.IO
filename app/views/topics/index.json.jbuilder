json.array!(@topics) do |topic|
  json.extract! topic, :id, :name, :subject_id
  json.url topic_url(topic, format: :json)
end
