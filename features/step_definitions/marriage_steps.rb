Given(/^the arrays to match are parsed from "(.*?)" and "(.*?)"$/) do |a1, a2|
  @array1, @array2 = [a1, a2].map { |a| JSON.parse(a) }
end

When(/^the match is called$/) do
  @result = Kantox::Marriage.go @array1, @array2
end

Then(/^result is "(.*?)"$/) do |result|
  expect(@result).to eq(JSON.parse(result))
end
