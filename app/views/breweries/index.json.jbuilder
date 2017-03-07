json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year, :active
  json.beers do
    json.amount brewery.beers.count
  end

end