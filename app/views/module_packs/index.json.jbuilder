json.array!(@module_packs) do |module_pack|
  json.extract! module_pack, :id, :name, :unit_id
  json.url module_pack_url(module_pack, format: :json)
end
