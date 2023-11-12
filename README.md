# Ipgeobase

Ipgeobase is a Ruby gem for retrieving location data based on an IP address using the ip-api.com service.

[![Tests](https://github.com/MarinaMoskaleva/ipgeobase/actions/workflows/main.yml/badge.svg)](https://github.com/MarinaMoskaleva/ipgeobase/actions)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ipgeobase'
```
And then execute:

```
bundle install
```
Or install it yourself as:
```
gem install ipgeobase
```

## Usage

```
require "ipgeobase"

# Lookup location data for a specific IP address
data = Ipgeobase.lookup("8.8.8.8")

# Accessing the retrieved data
puts "City: #{data.city}"
puts "Country: #{data.country}"
puts "Latitude: #{data.lat}"
puts "Longitude: #{data.lon}"
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MarinaMoskaleva/ipgeobase.
