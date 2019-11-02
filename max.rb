require 'pry'

input = {"markets"=>["BTCUSDT", "ETHUSDT", "LTCUSDT", "STEBTC", "STEETH", "STELTC", "STEUSDT"]}
output = "/"
input["markets"].each do |market|
  output += market.downcase
  unless market == input["markets"].last
    output += "|"
  end
end
output += "/"
pp output
