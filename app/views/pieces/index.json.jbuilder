json.array!(@pieces) do |piece|
  json.extract! piece, :id, :title, :image, :description, :dimensions, :views, :user_id, :price, :sold
  json.url piece_url(piece, format: :json)
end
