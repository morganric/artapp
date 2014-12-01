json.array!(@collections) do |collection|
  json.extract! collection, :id, :title, :user_id, :slug
  json.url collection_url(collection, format: :json)
end
