json.array!(@interventions) do |intervention|
  json.extract! intervention, :id, :problem, :fix
  json.url intervention_url(intervention, format: :json)
end
