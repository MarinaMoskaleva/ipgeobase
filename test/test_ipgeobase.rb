# frozen_string_literal: true

require_relative "test_helper"
# Test class for the Ipgeobase module.
class TestIpgeobase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_that_ip_is_incorrect
    assert_raises ArgumentError do
      Ipgeobase.lookup(nil)
    end
    assert_raises ArgumentError do
      Ipgeobase.lookup("")
    end
    assert_raises ArgumentError do
      Ipgeobase.lookup("invalid_ip")
    end
  end

  def test_fetches_data_from_api
    stub_request_data

    data = Ipgeobase.lookup("8.8.8.8")
    actual_data = [
      data.city,
      data.country,
      data.country_code,
      data.lat,
      data.lon
    ]

    assert(expected_data == actual_data)
  end

  private

  def stub_request_data
    stub_request(:get, "http://ip-api.com/xml/8.8.8.8")
      .to_return(status: 200, body: data_in_res, headers: {})
  end

  def expected_data
    [
      "Ashburn",
      "United States",
      "US",
      "39.03",
      "-77.5"
    ]
  end

  def data_in_res
    '<?xml version="1.0" encoding="UTF-8"?>
      <query>
        <status>success</status><country>United States</country>
        <countryCode>US</countryCode><region>VA</region>
        <regionName>Virginia</regionName><city>Ashburn</city>
        <zip>20149</zip><lat>39.03</lat><lon>-77.5</lon>
        <timezone>America/New_York</timezone>
        <isp>Google LLC</isp><org>Google Public DNS</org>
        <as>AS15169 Google LLC</as><query>8.8.8.8</query>
      </query>'
  end
end
