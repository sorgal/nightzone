json.array!(@admin_games) do |admin_game|
  json.extract! admin_game, :id, :admin_id, :game_id
  json.url admin_game_url(admin_game, format: :json)
end
