Given(/^the arrays to match are parsed from "(.*?)" and "(.*?)"$/) do |a1, a2|
  @array1, @array2 = [a1, a2].map { |a| JSON.parse(a) }
end

When(/^the match "(.*?)" is called$/) do |meth|
  @result = Kantox::Marriage.go meth.to_sym, @array1, @array2
end

When(/^the match "(.*?)" is called with units digit position "(.*?)"$/) do |meth, udp|
  udp = udp.to_i
  rounded = [@array1, @array2].map do |arr|
    arr.map { |e| e.round(-udp) } - [0]
  end
  @result = Kantox::Marriage.go meth.to_sym, *rounded
end

Then(/^result is "(.*?)"$/) do |result|
  expect(@result).to eq(JSON.parse(result))
end
