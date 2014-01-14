json.array!(@hints) do |hint|
  json.extract! hint, :id
  json.url hint_url(hint, format: :json)
end
