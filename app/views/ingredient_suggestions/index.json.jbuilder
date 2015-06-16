json.array!(@ingredient_suggestions) do |ingredient_suggestion|
  json.extract! ingredient_suggestion, :id, :item
  json.url ingredient_suggestion_url(ingredient_suggestion, format: :json)
end
