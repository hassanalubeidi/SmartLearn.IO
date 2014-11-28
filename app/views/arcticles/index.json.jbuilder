json.array!(@arcticles) do |arcticle|
  json.extract! arcticle, :id, :title, :body, :references
  json.url arcticle_url(arcticle, format: :json)
end
