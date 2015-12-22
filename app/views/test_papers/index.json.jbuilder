json.array!(@test_papers) do |test_paper|
  json.extract! test_paper, :id, :subject_id, :main_questions, :date, :calc_allowed
  json.url test_paper_url(test_paper, format: :json)
end
