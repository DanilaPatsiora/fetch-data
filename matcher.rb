require 'faraday'
require 'csv'
require 'json'
require 'pry'
responce = Faraday.get 'https://api.binance.com/api/v3/exchangeInfo' 
result = JSON.parse(responce.body)
markets = []
result["symbols"].each { |num| markets.push(num["symbol"])}

markets.each do |market|
    CSV.open("/Users/danilapatsiora/work/myProjects/back/historicaldata/test_candles/#{market}_ohlvc_1m.csv", "a") do |main|

        CSV.foreach("/Users/danilapatsiora/work/myProjects/back/historicaldata/test_candles/#{market}.csv", "r") do |my|
            if my.include?("name")
                next
            end
            kek = my[1].to_i
            my[1] = (kek*1000000).to_s
            main << my
        end
    rescue
        p 'error'
        next
    end
end