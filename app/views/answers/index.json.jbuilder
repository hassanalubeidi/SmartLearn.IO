json.array!(@answers) do |answer|
  json.extract! answer, :id, :question_id, :user_id, :text, :marks_integer
  json.url answer_url(answer, format: :json)
end
