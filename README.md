# Kantox::Marriage

The implementation of [Subset sum problem](http://en.wikipedia.org/wiki/Subset_sum_problem)
solution in ruby:

* pseudo-polynomial time dynamic programming solution
* polynomial time approximate algorithm

Basically, it’s adopted to be used for finding matches in two arrays. Input is expected to be:

* two arrays of positives;
* one array, containing all numbers

Ideas were gracefully stolen from [Alan Skorkin](http://www.skorks.com/2011/02/algorithms-a-dropbox-challenge-and-dynamic-programming/)
and [Jan Bussieck](http://www.janbussieck.com/subset-sum-problem-in-ruby/).

## Installation

```ruby
gem 'kantox-marriage'
```

## Usage

#### Precise matches

```ruby
Kantox::Marriage.go :matrix, [802, 421, 143, 137, 316, 150], [302, 611, 466, 42, 195, 295]
#⇒ [[316, 150], [466]]
Kantox::Marriage.go :approx, [802, 421, 143, 137, 316, 150], [302, 611, 466, 42, 195, 295]
#⇒ [[316, 150], [466]]
```

#### Inexact matches

To find inexact matches, one would round the inputs before processing:

```ruby
@udp = 3 # thousands
rounded = [@array1, @array2].map do |arr|
  arr.map { |e| e.round(-@udp) } - [0]
end
puts result = Kantox::Marriage.go :approx, *rounded
```

To turn back to exact values after a match was found:

```ruby
result.map!.with_index do |r, i|
  r.map do |e|
    @input[i].delete(@input[i].detect { |elem| elem.round(-@udp) == e })
  end
end
```

## Binaries:

```
$ sss_matrix "[802, 421, 143, 137, 316, 150]" "[302, 611, 466, 42, 195, 295]"
Input accepted:
	[802, 421, 143, 137, 316, 150]
	[302, 611, 466, 42, 195, 295]
Result is:
	[[316, 150], [466]]

```

For use in scripts (suppress any output save for result,) redirect `stderr`:

```
$ sss_approx "[802, 421, 143, 137, 316, 150]" "[302, 611, 466, 42, 195, 295]" 2>/dev/null
[[316, 150], [466]]%
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/kantox-marriage/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
