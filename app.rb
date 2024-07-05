require "sinatra"
require "sinatra/reloader"
require "http"
require "json"



get("/") do
  @exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
  @data = HTTP.get("https://api.exchangerate.host/list?access_key=#{@exchange_rate_key}").to_s
  @parsed_data = JSON.parse("#{@data}")
  @currencies = @parsed_data.fetch("currencies")
  erb(:home)
end

get("/:converter") do
  @exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
  @data = HTTP.get("https://api.exchangerate.host/list?access_key=#{@exchange_rate_key}").to_s
  @parsed_data = JSON.parse("#{@data}")
  @currencies = @parsed_data.fetch("currencies")
  @from = params.fetch("converter")
 
  erb(:finalize)
end

get("/:from/:to") do
  @from = params.fetch("from")
  @to = params.fetch("to")
  @exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
  @data = HTTP.get("https://api.exchangerate.host/convert?from=#{@from}&to=#{@to}&amount=1&access_key=#{@exchange_rate_key}").to_s
  @parsed_data = JSON.parse("#{@data}")
  @currencies = @parsed_data.fetch("result")
  erb(:result)
end
