json.array!(@questions) do |question|
  json.extract! question, :id, :topic_id, :text, :total_marks
  json.url question_url(question, format: :json)
end
