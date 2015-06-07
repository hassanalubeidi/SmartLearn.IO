json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :date, :subject_id, :title, :powerpoint
  json.url lesson_url(lesson, format: :json)
end
