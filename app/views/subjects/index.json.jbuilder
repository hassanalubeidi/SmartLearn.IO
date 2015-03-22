json.array!(@subjects) do |subject|
  json.extract! subject, :id
  json.url subject_url(subject, format: :json)
end
