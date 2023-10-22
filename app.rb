require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  raw_data = HTTP.get(api_url)

  raw_data_string = raw_data.to_s

  parsed_data = JSON.parse(raw_data_string)

  symbols = parsed_data.fetch("currencies")

  @abbreviations = symbols.keys


  erb(:homepage)
end

get("/:from_currency") do
  
  @original_currency = params.fetch("from_currency")


  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  raw_data = HTTP.get(api_url)

  raw_data_string = raw_data.to_s

  parsed_data = JSON.parse(raw_data_string)

  symbols = parsed_data.fetch("currencies")

  @abbreviations = symbols.keys
  

  erb(:currency)

end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"

  raw_data = HTTP.get(api_url)

  raw_data_string = raw_data.to_s

  parsed_data = JSON.parse(raw_data_string)

  @result = parsed_data.fetch("result")
 

  erb(:currency_conversion)

end
