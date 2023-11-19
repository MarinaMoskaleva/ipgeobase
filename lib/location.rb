# frozen_string_literal: true

require "happymapper"

# The Location class represents geographic location information
# parsed from IP geolocation API responses. It provides a structured
# representation of latitude, longitude, city, country, and country code.
class Location
  include HappyMapper
  tag "query"
    element :country, String
    element :countryCode, String, tag: "countryCode"
    element :city, String
    element :lat, Float
    element :lon, Float
end
