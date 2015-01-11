json.array!(@categories) do |category|
  json.extract! category, :id, :name, :twitter
  json.url category_url(category, format: :json)
end
