# frozen_string_literal: true

require_relative "ipgeobase/version"
require_relative "location"
require "faraday"
require "json"
require "happymapper"

# Ipgeobase module provides functionality for looking up location data based on IP address.
module Ipgeobase
  class Error < StandardError; end

  BASE_URL = "http://ip-api.com/xml/"
  class << self
    def lookup(ip)
      raise ArgumentError, "Invalid IP address format" unless valid_ip?(ip)

      url = "#{BASE_URL}#{ip}"
      response = send_request(url)
      parse_response(response)
    end

    private

    def send_request(url)
      response = Faraday.get url
      raise Ipgeobase::Error, "Failed to fetch data: #{response.status}" unless response.success?

      response.body
    end

    def parse_response(data)
      raise Ipgeobase::Error, "Error: #{data["message"]}" if data["status"] == "fail"

      parse_location(data)
    end

    def parse_location(data)
      Location.parse(data)
    end

    def valid_ip?(ip)
      ip_regex = /\A(?:[0-9]{1,3}\.){3}[0-9]{1,3}\z|\A(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}\z/

      !!(ip =~ ip_regex)
    end
  end
end
