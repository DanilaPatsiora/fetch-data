require 'faraday'
require 'csv'
require 'json'
require 'pry'
responce = Faraday.get 'https://api.binance.com/api/v3/exchangeInfo' 
result = JSON.parse(responce.body)
markets = []
result["symbols"].each { |num| markets.push(num["symbol"])}
first_date =1571295000000
last_date = 1572378540000
tickers=[]
markets=["ETHBTC", "BTCTUSD"]
markets.each do |market|  
  CSV.open("/Users/danilapatsiora/work/myProjects/back/historicaldata/test_candles/#{market.downcase}_ohlvc_1m.csv", "a") do |csv|
    timestamp = first_date
    pp market

    until timestamp >= last_date do
      responce = Faraday.get('https://api.binance.com/api/v3/klines', {symbol: market, limit:1000, startTime: timestamp, endTime: last_date, interval: '1m' }, { 'X-MBX-APIKEY' => 'PVwqPtv6qJ369oX1Fw06zRb7vEh8DLBORrcO6L9aP0SfoN1OT8u8vqMhuY8QSw7G'})
      if responce.body == "[]"
        break
      end
      pp responce.body
      tickers += JSON.parse(responce.body)
      timestamp = tickers.last[6] + 1
    end
    tickers.each do | kline |
      csv << ["candles_60", kline[0] * 1000000 , "binance", market.downcase, kline[1], kline[4], kline[2], kline[3], kline[5]]
    end
    tickers=[]
    timestamp = first_date
  end

end