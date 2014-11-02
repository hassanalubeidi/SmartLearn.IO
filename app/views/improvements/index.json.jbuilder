json.array!(@improvements) do |improvement|
  json.extract! improvement, :id, :topic, :area_to_improve, :checked, :user_id
  json.url improvement_url(improvement, format: :json)
end
