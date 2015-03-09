json.array!(@items) do |item|
  json.extract! item, :id, :user_id, :asin, :title, :thumb_url, :release_date
  json.url item_url(item, format: :json)
end
