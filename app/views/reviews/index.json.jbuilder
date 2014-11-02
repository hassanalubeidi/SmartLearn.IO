json.array!(@reviews) do |review|
  json.extract! review, :id, :user_id, :improvement_id
  json.url review_url(review, format: :json)
end
